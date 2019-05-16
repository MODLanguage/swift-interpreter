//
//  ModlObjectCreator.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
fileprivate enum ReservedKeys: String, CaseIterable {
    case version = "*VERSION"
    case versionSH = "*V"
    case mClassSH = "*C"
    case mClass = "*CLASS"
    case objectIndex = "?"
    case objectReference = "_"
}

struct ModlObjectCreator {
    
    var classManager = ModlClassManager()
    var objectRefManager = ModlObjectReferenceManager()
    var stringTransformer = StringTransformer()
    
    func createOutput(_ input: ModlListenerObject) -> ModlOutputObject? {
        let output = ModlOutputObject()
        for structure in input.structures {
            if let outStructure = processModlElement(structure) as? ModlStructure {
                output.addStructure(outStructure)
                if let pair = outStructure as? ModlPair {
                    objectRefManager.addKeyedVariable(pair)
                }
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
            if processReservedPair(key: iPair.key, value: iPair.value) {
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
            pair.key = stringTransformer.transformKeyString(iPair.key, objectMgr: objectRefManager)
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
                if processReservedPair(key: key, value: originalValue) {
                    continue
                }
                var newProcessedClasses = classIdsProcessedInBranch
                if let classReference = classManager.processFromClass(key: key, value: originalValue), let mValue = processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses), let uwKey = classReference.key, !haveAlreadyProcessedClassInBranch(identifier: uwKey, processedList: newProcessedClasses) {
                    newProcessedClasses.append(uwKey)
                    newProcessedClasses.append(key)
                    map.addValue(key: uwKey, value: mValue)
                } else if let mValue = processModlElement(originalValue, classIdsProcessedInBranch: newProcessedClasses){
                    let transKey = stringTransformer.transformKeyString(key, objectMgr: objectRefManager) ?? key
                    map.addValue(key: transKey, value: mValue)
                }
            }
            return map
        case is ModlNull:
            return ModlOutputObject.Null()
        case let iPrim as ModlPrimitive:
            if let strValue = iPrim.value as? String, let transformed = stringTransformer.transformString(strValue, objectMgr: objectRefManager) {
                if (transformed as? ModlPrimitive)?.asString() == strValue {
                    //nothing has or will change so stop transforming
                } else {
                    return processModlElement(transformed, classIdsProcessedInBranch: classIdsProcessedInBranch)
                }
            }
            
            let prim = ModlOutputObject.Primitive()
            prim.value = iPrim.value
            return prim
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
        if key.hasPrefix(ReservedKeys.objectReference.rawValue) {
            return true
        }
        return ReservedKeys(rawValue: key.uppercased()) != nil
    }
    
    
    private func processReservedPair(key: String?, value: ModlValue?) -> Bool {
        guard let uwKey = key else {
            return false
        }
        var reserved = ReservedKeys(rawValue: uwKey.uppercased())
        if uwKey.hasPrefix(ReservedKeys.objectReference.rawValue) {
            reserved = .objectReference
        }
        guard let uwReserved = reserved else {
            return false
        }
        switch uwReserved {
        case .version, .versionSH:
            //Could raise an error here for non-matching version.... although json test implies it just continues
            return true
        case .mClass, .mClassSH:
            //TODO: process class
            classManager.addClass(value)
            return true
        case .objectIndex:
            let processed = processModlElement(value)
            objectRefManager.addIndexedVariables(processed)
            return true
        case .objectReference:
            let objPair = ModlOutputObject.Pair()
            objPair.key = uwKey
            objPair.value = processModlElement(value)
            objectRefManager.addKeyedVariable(objPair)
            return true
        }
    }
}
