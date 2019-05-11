//
//  ModlClassManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 09/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

fileprivate enum ClassSpecialKeys: String, CaseIterable {
    case identifier = "*id"
    case identifierSH = "*i"
    case name = "*name"
    case nameSH = "*n"
    case assign = "*assign"
    case assignSH = "*a"
    case superclass = "*superclass"
    case superclassSH = "*s"
}


class ModlClassManager {
    
    private enum PrimitiveSuperclassType: String, CaseIterable {
        case num
        case str
        case map
        case arr
    }
    
    
    private var storedClasses: [String: ModlClass] = [:]

    func addClass(_ classMap: ModlValue?) {
        guard let input = classMap as? ModlMap, var mClass = ModlClass(input) else {
            //either not a map, or has no id so ignore ...
            //TODO: raise bad class error?
            return
        }
        if let superclassName = mClass.superclass {
            if superclassName.uppercased() == superclassName {
                //cannot inherit from immutable class
                //TODO: throw an error?
                return
            }
           //has a superclass mentioned so check for it....
            if let existingingSuperClass = getClass(superclassName) {
                //TODO: this should probably loop through and update individual bits rather than overwrite
                mClass.assignMap = existingingSuperClass.assignMap
                //TODO: do I group here or construct later?
                //                mClass.extraValues = existingingSuperClass.extraValues
            }
        }
        storedClasses[mClass.id] = mClass
     }
    
    func isClass(_ keyValue: String?) -> Bool {
        return getClass(keyValue) != nil
    }
    
    private func getClass(_ identifier: String?) -> ModlClass? {
        guard let uwId = identifier else {
            return nil
        }
        return storedClasses.first(where: { (key, value) -> Bool in
            return value.name == uwId || key == uwId
        })?.value
    }
    
    func processFromClass(_ input: ModlValue?, classIdentifier: String?) -> ModlPair? {
        guard let uwInput = input as? ModlPair, let uwClassId = classIdentifier, let classObj = getClass(uwClassId) else {
            return nil
        }
        let outputPair = ModlOutputObject.Pair()
        outputPair.key = classObj.name

        if let prim = findPrimitive(classObj.superclass) {
            switch prim {
            case .str:
                if let pairValue = uwInput.value as? ModlPrimitive {
                    let replacement = ModlListenerObject.Primitive()
                    replacement.value = pairValue.asString()
                    outputPair.value = replacement
                    return outputPair
                }
            case .map:
                let replacement = ModlListenerObject.Map()
                let extraDetails = constructAdditionalItems(classObj.superclass).reversed()
                for detail in extraDetails {
                    if let key = detail.key, let value = detail.value {
                        replacement.addValue(key: key, value: value)
                    }
                }
                if let pairValue = uwInput.value as? ModlArray {
                    //TODO: handle assign
                } else if let pairValue = uwInput.value as? ModlMap {
                    for key in pairValue.orderedKeys {
                        if let value = pairValue.value(forKey: key) {
                            replacement.addValue(key: key, value: value)
                        }
                    }
                    for detail in classObj.extraValues {
                        if let uwKey = detail.key, let uwValue = detail.value {
                            replacement.addValue(key: uwKey, value: uwValue)
                        }
                    }
                }
                outputPair.value = replacement
                return outputPair
            default:
                break
            }
        }
        outputPair.value = uwInput.value
        return outputPair
    }
    
    private func findPrimitive(_ superclassId: String?) -> PrimitiveSuperclassType? {
        guard let uwId = superclassId else {
            return nil
        }
        if let nextClass = getClass(uwId) {
            return findPrimitive(nextClass.superclass)
        } else {
            return PrimitiveSuperclassType(rawValue: uwId)
        }
    }
    
    private func constructAdditionalItems(_ classId: String?, passedData: [ModlPair] = [] ) -> [ModlPair] {
        guard let uwId = classId, let currentClass = getClass(uwId) else {
            return passedData
        }
        print("Current ID: \(currentClass.name)")
        print("Next ID: \(currentClass.superclass)")
        print("Current extra \(currentClass.extraValues.first?.key)")
        print("List extra \(dump(passedData))")
        return constructAdditionalItems(currentClass.superclass, passedData: passedData + currentClass.extraValues)
    }
}


fileprivate struct ModlClass {
    let id: String
    var superclass: String? = nil
    var name: String
    var assignMap: Any?
    var extraValues: [ModlPair] = []
    
    init?(_ map: ModlValue?) {
        guard let classMap = map as? ModlMap else {
            return nil
        }
        if let mClassId = classMap.value(forKeys: ["*i", "*id"], ignoreCase: true) as? ModlPrimitive, let classId = mClassId.asString() {
            id = classId
            superclass = (classMap.value(forKeys: ["*s", "*superclass"], ignoreCase: true) as? ModlPrimitive)?.asString()
            name = (classMap.value(forKeys: ["*n", "*name"], ignoreCase: true) as? ModlPrimitive)?.asString() ?? classId
            assignMap = classMap.value(forKeys: ["*a", "*assign"], ignoreCase: true)
            let nonSpecialKeys = classMap.orderedKeys.filter { (key) -> Bool in
                return ClassSpecialKeys(rawValue: key.lowercased()) == nil
            }
            for key in nonSpecialKeys {
                let newPair = ModlListenerObject.Pair()
                newPair.key = key
                newPair.value = classMap.value(forKey: key)
                extraValues.append(newPair)
            }
        } else {
            return nil
        }
    }
}



