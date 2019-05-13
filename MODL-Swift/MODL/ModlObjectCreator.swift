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
    var stringTransformer = StringTransformer()

    func createOutput(_ input: ModlListenerObject) -> ModlOutputObject? {
        let output = ModlOutputObject()
        for structure in input.structures {
            if let outStructure = processModlElement(structure) as? ModlStructure {
                output.addStructure(outStructure)
            }
        }
        return output
    }
    
    private func processModlElement(_ element: ModlValue?, classIdsProcessedInBranch: [String] = []) -> ModlValue? {
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
            if let classReference = classManager.processFromClass(key: iPair.key, value: iPair.value), !haveAlreadyProcessedClassInBranch(identifier: iPair.key, processedList: classIdsProcessedInBranch) {
                var newProcessedClasses = classIdsProcessedInBranch
                newProcessedClasses.append(iPair.key ?? "")
                newProcessedClasses.append(classReference.key ?? "")
                pair.key = classReference.key
                pair.value = processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses)
                return pair
            }
            pair.value = processModlElement(iPair.value, classIdsProcessedInBranch: classIdsProcessedInBranch)
            return pair
        case let iArray as ModlArray:
            let array = ModlOutputObject.Array()
            array.values = iArray.values.compactMap({ (value) -> ModlValue? in
                return processModlElement(value, classIdsProcessedInBranch: classIdsProcessedInBranch)
            })
            return array
        case let iMap as ModlMap:
            let map = ModlOutputObject.Map()
            for key in iMap.orderedKeys {
                let originalValue = iMap.value(forKey: key)
                var newProcessedClasses = classIdsProcessedInBranch
                if let classReference = classManager.processFromClass(key: key, value: originalValue), let mValue = processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses), let uwKey = classReference.key, !haveAlreadyProcessedClassInBranch(identifier: uwKey, processedList: newProcessedClasses) {
                    newProcessedClasses.append(uwKey)
                    newProcessedClasses.append(key)
                    map.addValue(key: uwKey, value: mValue)
                } else if let mValue = processModlElement(originalValue, classIdsProcessedInBranch: newProcessedClasses){
                    map.addValue(key: key, value: mValue)
                }
            }
            return map
        case is ModlNull:
            return ModlOutputObject.Null()
        case let iPrim as ModlPrimitive:
            if let strValue = iPrim.value as? String {
                return stringTransformer.transformString(strValue)
            } else {
                let prim = ModlOutputObject.Primitive()
                prim.value = iPrim.value
                return prim
            }
        default:
            return nil
        }
    }
    
    private func haveAlreadyProcessedClassInBranch(identifier: String?, processedList: [String]) -> Bool {
        guard let uwId = identifier, uwId.count > 0 else {
            return false
        }
        return processedList.contains(uwId)
    }
    
    
    //    //returns bool for existence of special reserved key
    private func hasReservedPairKey(_ pair: ModlPair) -> Bool {
        guard let key = pair.key else {
            return false
        }
        let reservedKeys = ["*VERSION", "*V","*C", "*c", "*CLASS", "*class"]
        return reservedKeys.contains(key)
    }
    
    
    private func processReservedPair(_ pair: ModlPair) -> Bool {
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
