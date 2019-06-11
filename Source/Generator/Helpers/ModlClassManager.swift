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
//  ModlClassManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 09/05/2019.
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
    private var classOrder: [String] = []
    
    func addClass(_ classMap: ModlValue?) {
        guard let input = classMap as? ModlMap, let mClass = ModlClass(input) else {
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
        }
        storedClasses[mClass.id] = mClass
        classOrder.append(mClass.id)
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
        var outputPair = ModlOutputObject.Pair()
        outputPair.key = classObj.name
        //TODO: work out prim from pair value if superclass doesn't have one....
        if let prim = findPrimitiveType(classObj) {
            switch prim {
            case .str:
                if let pairValue = uwValue as? ModlPrimitive {
                    var replacement = ModlListenerObject.Primitive()
                    replacement.value = pairValue.asString()
                    outputPair.value = replacement
                    return outputPair
                }
            case .map:
                var replacement = ModlListenerObject.Map()
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
                } else if let pValue = uwValue as? ModlPrimitive {
                    let assignList = constructAssignList(classObj.name)
                    if let matching = assignList.first(where: { (array) -> Bool in
                        return array.values.count == 1
                    }) ?? assignList.sorted(by: { (first, second) -> Bool in
                        return first.values.count > second.values.count
                    }).first {
                        for matchingKey in matching.values{
                            if let keyStr = (matchingKey as? ModlPrimitive)?.asString() {
                                let value = pValue
                                replacement.addValue(key: keyStr, value: value)
                            }
                        }
                    }
                    if replacement.values.count == 0 {
                        replacement.addValue(key: "value", value: pValue)
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
            case .num:
                if let pairValue = uwValue as? ModlPrimitive {
                    var replacement = ModlListenerObject.Primitive()
                    replacement.value = pairValue.asNumber()
                    outputPair.value = replacement
                    return outputPair
                }
            case .arr:
                if let prim = uwValue as? ModlPrimitive {
                    var replacement = ModlListenerObject.Array()
                    replacement.addValue(prim)
                    outputPair.value = replacement
                    return outputPair
                }
            }
        }
        outputPair.value = uwValue
        return outputPair
    }
    
    private func findPrimitiveType(_ mClass: ModlClass?) -> PrimitiveSuperclassType? {
        guard let currClass = mClass else {
            return nil
        }
        if currClass.extraValues.count > 0 {
            return .map
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
    
    func referenceInstruction() -> ModlOutputObject.Array {
        let classArr = classOrder.compactMap({ (classId) -> ModlValue? in
            if let mClass = storedClasses[classId] {
                return mClass.referenceInstruction()
            }
            return nil
        })
        var output = ModlOutputObject.Array()
        output.values = classArr
        return output
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
                var newPair = ModlListenerObject.Pair()
                newPair.key = key
                newPair.value = classMap.value(forKey: key)
                extraValues.append(newPair)
            }
        } else {
            return nil
        }
    }
    
    func referenceInstruction() -> ModlOutputObject.Pair {
        var pair = ModlOutputObject.Pair()
        var map = ModlOutputObject.Map()
        map.addValue(key: "name", value: ModlOutputObject.Primitive(name))
        if let sClass = superclass {
            map.addValue(key: "superclass", value: ModlOutputObject.Primitive(sClass))
        }
        if let assignList = assignMap {
            var transformedList = ModlOutputObject.Array()
            for case let assignItem as ModlArray in assignList.values {
                var assignSubList = ModlOutputObject.Array()
                for case let item as ModlPrimitive in assignItem.values where item.asString() != nil {
                    let newPrim = ModlOutputObject.Primitive(item.asString()!)
                    assignSubList.addValue(newPrim)
                }
                transformedList.addValue(assignSubList)
            }
            map.addValue(key: "assign", value: transformedList)
        }
        if extraValues.count > 0 {
            for pair in extraValues {
                if let key = pair.key, let value = pair.value {
                    var convertedValue: ModlValue? = nil
                    switch value {
                    case let prim as ModlPrimitive:
                        var oPrim = ModlOutputObject.Primitive()
                        oPrim.value = prim.value
                        convertedValue = oPrim
                    default:
                        //TODO: other conversions
                        break
                    }
                    if let conv = convertedValue {
                        map.addValue(key: key, value: conv)
                    }
                }
            }
        }
        pair.key = id
        pair.value = map
        return pair
    }
}



