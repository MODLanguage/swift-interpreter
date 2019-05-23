/*
 MIT License
 
 Copyright (c) 2018 NUM Technology Ltd
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  ModlObjectCreator.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
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
            var pair = ModlOutputObject.Pair()
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
            objectRefManager.addKeyedVariable(key: pair.key, value: pair.value)
            return pair
        case let iArray as ModlArray:
            var array = ModlOutputObject.Array()
            array.values = iArray.values.compactMap({ (value) -> ModlValue? in
                return processModlElement(value, classIdsProcessedInBranch: classIdsProcessedInBranch)
            })
            return array
        case let iMap as ModlMap:
            var map = ModlOutputObject.Map()
            for key in iMap.orderedKeys {
                let originalValue = iMap.value(forKey: key)
                if processReservedPair(key: key, value: originalValue) {
                    continue
                }
                var newProcessedClasses = classIdsProcessedInBranch
                var mapKey = key
                var mapValue = originalValue
                if let classReference = classManager.processFromClass(key: key, value: originalValue), let mValue = processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses), let uwKey = classReference.key, !haveAlreadyProcessedClassInBranch(identifier: uwKey, processedList: newProcessedClasses) {
                    newProcessedClasses.append(uwKey)
                    newProcessedClasses.append(key)
                    mapKey = uwKey
                    mapValue = mValue
                } else if let mValue = processModlElement(originalValue, classIdsProcessedInBranch: newProcessedClasses){
                    mapKey = stringTransformer.transformKeyString(key, objectMgr: objectRefManager) ?? key
                    mapValue = mValue
                }
                if let uwValue = mapValue {
                    map.addValue(key: mapKey, value: uwValue)
                    objectRefManager.addKeyedVariable(key: mapKey, value: mapValue)
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
            var prim = ModlOutputObject.Primitive()

            if let processed = stringTransformer.processStringForMethods(iPrim.value as? String) {
                prim.value = processed
            } else {
                prim.value = iPrim.value
            }
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
            var objPair = ModlOutputObject.Pair()
            objPair.key = uwKey
            objPair.value = processModlElement(value)
            objectRefManager.addKeyedVariable(key: objPair.key, value: objPair.value)
            return true
        }
    }
    
//    private func processStructureForMethods(_ structure: ModlValue?) -> ModlValue? {
//        guard let uwStruct = structure else {
//            return nil
//        }
//        switch uwStruct {
//        case let iPair as ModlPair:
//            iPair.key = stringTransformer.processStringForMethods(iPair.key)
//            iPair.value = processStructureForMethods(iPair.value)
//            return iPair
//        case let iArray as ModlArray:
//            let array = ModlOutputObject.Array()
//            array.values = iArray.values.compactMap({ (value) -> ModlValue? in
//                return processStructureForMethods(value)
//            })
//            return array
//        case let iMap as ModlMap:
//            let map = ModlOutputObject.Map()
//            for key in iMap.orderedKeys {
//                let originalValue = iMap.value(forKey: key)
//                if let newValue = processStructureForMethods(originalValue), let newKey = stringTransformer.processStringForMethods(key) {
//                    map.addValue(key: newKey, value: newValue)
//                }
//            }
//            return map
//        case is ModlNull:
//            return structure
//        case let iPrim as ModlPrimitive:
//            if let strValue = iPrim.value as? String {
//                iPrim.value = stringTransformer.processStringForMethods(strValue)
//            }
//            return iPrim
//        default:
//            return nil
//        }
//    }
}
