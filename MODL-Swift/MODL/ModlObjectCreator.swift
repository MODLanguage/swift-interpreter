//
//  ModlObjectCreator.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct ModlObjectCreator {
    
    var classManager = ModlClassManager()

    func createOutput(_ input: ModlListenerObject) -> ModlOutputObject? {
        let output = ModlOutputObject()
        for structure in input.structures {
            if let outStructure = processModlElement(structure) as? ModlStructure {
                output.addStructure(outStructure)
            }
        }
        return output
    }
    
    private func processModlElement(_ element: ModlValue?) -> ModlValue? {
        guard let uwElement = element else {
            return nil
        }
        switch uwElement {
        case let iPair as ModlPair:
            let pair = ModlOutputObject.Pair()
            pair.key = iPair.key
            if processReservedPair(iPair) {
                return nil
            }
            if let classReference = classManager.processFromClass(key: iPair.key, value: iPair.value){
                pair.key = classReference.key
                pair.value = processModlElement(classReference.value)
                return pair
            }
            pair.value = processModlElement(iPair.value)
            return pair
        case let iArray as ModlArray:
            let array = ModlOutputObject.Array()
            array.values = iArray.values.compactMap({ (value) -> ModlValue? in
                return processModlElement(value)
            })
            return array
        case let iMap as ModlMap:
            let map = ModlOutputObject.Map()
            for key in iMap.orderedKeys {
                let originalValue = iMap.value(forKey: key)
                if let classReference = classManager.processFromClass(key: key, value: originalValue), let mValue = processModlElement(classReference.value), let uwKey = classReference.key {
                    map.addValue(key: uwKey, value: mValue)
                } else if let mValue = processModlElement(originalValue){
                    map.addValue(key: key, value: mValue)
                }
            }
            return map
        case is ModlNull:
            return ModlOutputObject.Null()
        case let iPrim as ModlPrimitive:
            let prim = ModlOutputObject.Primitive()
            prim.value = iPrim.value
            return prim
        default:
            return nil
        }
    }
    
    
    //    //returns bool for existence of special reserved key
    func hasReservedPairKey(_ pair: ModlPair) -> Bool {
        guard let key = pair.key else {
            return false
        }
        let reservedKeys = ["*VERSION", "*V","*C", "*c", "*CLASS", "*class"]
        return reservedKeys.contains(key)
    }
    
    
    func processReservedPair(_ pair: ModlPair) -> Bool {
        guard let key = pair.key else {
            return false
        }
        switch key {
        case "*VERSION", "*V":
            //Could raise an error here for non-matching version.... although json test implies it just continues
            return true
        case "*C", "*c", "*CLASS", "*class":
            //TODO: process class
            classManager.addClass(pair.value)
            return true
        default:
            return false
        }
    }

}
