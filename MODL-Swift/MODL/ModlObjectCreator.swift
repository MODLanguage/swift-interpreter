//
//  ModlObjectCreator.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct ModlObjectCreator {
    func createOutput(_ input: ModlInitialObject) -> ModlOutputObject? {
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
        case let iPair as ModlInitialObject.Pair:
            let pair = ModlOutputObject.Pair()
            pair.key = iPair.key
            pair.value = processModlElement(iPair.value)
            return pair
        case let iArray as ModlInitialObject.Array:
            let array = ModlOutputObject.Array()
            array.values = iArray.values.compactMap({ (value) -> ModlValue? in
                return processModlElement(value)
            })
            return array
        case let iMap as ModlInitialObject.Map:
            let map = ModlOutputObject.Map()
            for (key, value) in iMap.values {
                map.values[key] = processModlElement(value)
            }
            map.orderedKeys = iMap.orderedKeys
            return map
        case is ModlInitialObject.Null:
            return ModlOutputObject.Null()
        case let iPrim as ModlInitialObject.Primitive:
            let prim = ModlOutputObject.Primitive()
            prim.value = iPrim.value
            return prim
        default:
            return nil
        }
    }
}
