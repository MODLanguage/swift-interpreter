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
    
    func processFromClass(key: String?, value: ModlValue?) -> ModlPair? {
        guard let uwValue = value, let classObj = getClass(key) else {
            return nil
        }
        let outputPair = ModlOutputObject.Pair()
        outputPair.key = classObj.name
        //TODO: work out prim from pair value if superclass doesn't have one....
        if let prim = findPrimitiveType(classObj) {
            switch prim {
            case .str:
                if let pairValue = uwValue as? ModlPrimitive {
                    let replacement = ModlListenerObject.Primitive()
                    replacement.value = pairValue.asString()
                    outputPair.value = replacement
                    return outputPair
                }
            case .map:
                let replacement = ModlListenerObject.Map()
                let assignList = constructAssignList(classObj.name)
                if let pairValue = uwValue as? ModlArray {
                    if let matching = assignList.first(where: { (array) -> Bool in
                            return array.values.count == pairValue.values.count
                    }) ?? assignList.sorted(by: { (first, second) -> Bool in
                        return first.values.count > second.values.count
                    }).first {
                        for (index, matchingKey) in matching.values.enumerated() {
                            if let keyStr = (matchingKey as? ModlPrimitive)?.asString() {
                                let value = pairValue.values[index]
                                replacement.addValue(key: keyStr, value: value)
                            }
                        }
                    }
                } else if let pairValue = uwValue as? ModlMap {
                    for key in pairValue.orderedKeys {
                        if let value = pairValue.value(forKey: key) {
                            replacement.addValue(key: key, value: value)
                        }
                    }
                }
                let extraDetails = constructAdditionalItems(classObj.name)
                for detail in extraDetails {
                    if let detailKey = detail.key, let value = detail.value {
                        replacement.addValue(key: detailKey, value: value)
                    }
                }
                outputPair.value = replacement
                return outputPair
            default:
                break
            }
        }
        outputPair.value = uwValue
        return outputPair
    }
    
    private func findPrimitiveType(_ mClass: ModlClass?) -> PrimitiveSuperclassType? {
        guard let currClass = mClass else {
            return nil
        }
        if let nextClass = getClass(currClass.superclass) {
            return findPrimitiveType(nextClass)
        } else {
            if let explicitSuper = currClass.superclass, let explicitPrim = PrimitiveSuperclassType(rawValue: explicitSuper) {
                return explicitPrim
            } else if currClass.assignMap != nil {
                return .map
            }
            else {
                return nil
            }
        }
    }
    
    private func constructAdditionalItems(_ classId: String?, passedData: [ModlPair] = [] ) -> [ModlPair] {
        guard let uwId = classId, let currentClass = getClass(uwId) else {
            return passedData
        }
        return constructAdditionalItems(currentClass.superclass, passedData: passedData + currentClass.extraValues)
    }
    
    private func constructAssignList(_ classId: String?, passedData: [ModlArray] = []) -> [ModlArray] {
        guard let uwId = classId, let currentClass = getClass(uwId) else {
            return passedData
        }
        var newData = passedData
        if let assign = currentClass.assignMap?.values as? [ModlArray] {
            newData += assign
        }
        return constructAssignList(currentClass.superclass, passedData: newData)
    }
}


fileprivate struct ModlClass {
    let id: String
    var superclass: String? = nil
    var name: String
    var assignMap: ModlArray?
    var extraValues: [ModlPair] = []
    
    init?(_ map: ModlValue?) {
        guard let classMap = map as? ModlMap else {
            return nil
        }
        if let mClassId = classMap.value(forKeys: ["*i", "*id"], ignoreCase: true) as? ModlPrimitive, let classId = mClassId.asString() {
            id = classId
            superclass = (classMap.value(forKeys: ["*s", "*superclass"], ignoreCase: true) as? ModlPrimitive)?.asString()
            name = (classMap.value(forKeys: ["*n", "*name"], ignoreCase: true) as? ModlPrimitive)?.asString() ?? classId
            assignMap = classMap.value(forKeys: ["*a", "*assign"], ignoreCase: true) as? ModlArray
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



