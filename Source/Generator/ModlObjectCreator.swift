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
fileprivate enum ReservedKey: String, CaseIterable {
    case version = "*VERSION"
    case versionSH = "*V"
    case mClassSH = "*C"
    case mClass = "*CLASS"
    case methodSH = "*M"
    case method = "*METHOD"
    case load = "*LOAD"
    case loadSH = "*L"
    case objectIndex = "?"
    case objectReference = "_"
}

internal struct ModlObjectCreator {
    
    var classManager = ModlClassManager()
    var objectRefManager = ModlObjectReferenceManager()
    var methodManager = MethodManager()
    var stringTransformer: StringTransformer
    var fileLoader: FileLoader
    
    init(_ fileLoader: FileLoader) {
        self.fileLoader = fileLoader
        self.stringTransformer = StringTransformer(objectManager: self.objectRefManager, methodManager: self.methodManager)
    }
    
    func createOutput(_ input: ModlListenerObject?) throws -> ModlOutputObject? {
        guard let uwInput = input else {
            return nil
        }
        let output = ModlOutputObject()
        for structure in uwInput.structures {
            if let outStructures = try processModlElement(structure) as? [ModlStructure] {
                for singleStruct in outStructures {
                    output.addStructure(singleStruct)
                }
            }
       }
        return output
    }
    
    private func processModlElement(_ element: ModlValue?, classIdsProcessedInBranch: [String] = []) throws -> [ModlValue]? {
        guard let uwElement = element else {
            return nil
        }
        switch uwElement {
        case let iPair as ModlPair:
            var pair = ModlOutputObject.Pair()
           
            if  let reservedPair = try processReservedPair(key: iPair.key, value: iPair.value) {
                if case ReservedKey.load = reservedPair {
                    return try processLoad(iPair.value)
                }
                return nil
            }
            if let classReference = classManager.processFromClass(key: iPair.key, value: iPair.value), !haveAlreadyProcessedClassInBranch(identifier: iPair.key, processedList: classIdsProcessedInBranch) {
                var newProcessedClasses = classIdsProcessedInBranch
                newProcessedClasses.append(iPair.key ?? "")
                newProcessedClasses.append(classReference.key ?? "")
                pair.key = classReference.key
                pair.value = try processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses)?.first
                return [pair]
            }
            pair.key = stringTransformer.transformKeyString(iPair.key)
            pair.value = try processModlElement(iPair.value, classIdsProcessedInBranch: classIdsProcessedInBranch)?.first
            objectRefManager.addKeyedVariable(key: pair.key, value: pair.value)
            return [pair]
        case let iArray as ModlArray:
            var array = ModlOutputObject.Array()
            array.values = try iArray.values.compactMap({ (value) -> ModlValue? in
                return try processModlElement(value, classIdsProcessedInBranch: classIdsProcessedInBranch)?.first
            })
            return [array]
        case let iMap as ModlMap:
            var map = ModlOutputObject.Map()
            for key in iMap.orderedKeys {
                let originalValue = iMap.value(forKey: key)
                
                if let reservedPair = try processReservedPair(key: key, value: originalValue) {
                    if case ReservedKey.load = reservedPair {
                        return try processLoad(originalValue)
                    }
                    continue
                }
                var newProcessedClasses = classIdsProcessedInBranch
                var mapKey = key
                var mapValue = originalValue
                if let conditional = originalValue as? ModlMapConditional, let returnedPair = try processConditional(conditional)?.first as? ModlPair, let newKey = returnedPair.key {
                    mapKey = newKey
                    mapValue = returnedPair.value
                } else if  let classReference = classManager.processFromClass(key: key, value: originalValue), let uwKey = classReference.key, !haveAlreadyProcessedClassInBranch(identifier: uwKey, processedList: newProcessedClasses), let mValue = try processModlElement(classReference.value, classIdsProcessedInBranch: newProcessedClasses) {
                    newProcessedClasses.append(uwKey)
                    newProcessedClasses.append(key)
                    mapKey = uwKey
                    mapValue = mValue.first
                } else if let mValue = try processModlElement(originalValue, classIdsProcessedInBranch: newProcessedClasses){
                    mapKey = stringTransformer.transformKeyString(key) ?? key
                    mapValue = mValue.first
                }
                if let uwValue = mapValue {
                    map.addValue(key: mapKey, value: uwValue)
                    objectRefManager.addKeyedVariable(key: mapKey, value: mapValue)
                }
            }
            return [map]
        case is ModlNull:
            return [ModlOutputObject.Null()]
        case let iPrim as ModlPrimitive:
            if let iPrimStr = iPrim.asString(), iPrimStr.hasPrefix("%*"), let value = processReferenceInstruction(key: iPrimStr, classIdsProcessedInBranch: classIdsProcessedInBranch){
                return [value]
            }
            if let strValue = iPrim.value as? String, let transformed = stringTransformer.transformString(strValue) {
                if (transformed as? ModlPrimitive)?.asString() == strValue {
                    //nothing has or will change so stop transforming
                } else {
                    return try processModlElement(transformed, classIdsProcessedInBranch: classIdsProcessedInBranch)
                }
            }
            var prim = ModlOutputObject.Primitive()

            if let processed = methodManager.processStringForMethods(iPrim.value as? String) {
                prim.value = processed
            } else {
                prim.value = iPrim.value
            }
            return [prim]
        case let topLevelConditional as ModlTopLevelConditional:
            return try processConditional(topLevelConditional)
        case let valueConditional as ModlValueConditional:
            return try processConditional(valueConditional)
        case let arrayConditional as ModlArrayConditional:
            return try processConditional(arrayConditional)
        case let mapConditional as ModlMapConditional:
            return try processConditional(mapConditional)
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
    private func hasReservedPairKey(_ pair: ModlPair) -> ReservedKey? {
        guard let key = pair.key else {
            return nil
        }
        if key.hasPrefix(ReservedKey.objectReference.rawValue) {
            return ReservedKey.objectReference
        }
        return ReservedKey(rawValue: key.uppercased())
    }
    
    
    private func processReservedPair(key: String?, value: ModlValue?) throws -> ReservedKey? {
        guard let uwKey = key else {
            return nil
        }
        var reserved = ReservedKey(rawValue: uwKey.uppercased())
        if uwKey.hasPrefix(ReservedKey.objectReference.rawValue) {
            reserved = .objectReference
        }
        guard let uwReserved = reserved else {
            return nil
        }
        switch uwReserved {
        case .version, .versionSH:
            //Could raise an error here for non-matching version.... although json test implies it just continues
            if let mPrim = value as? ModlPrimitive, let decVersion = mPrim.asNumber() {
                if Double(truncating: decVersion as NSNumber) != ModlListener.ModlVersion {
                    //Could raise an error here for non-matching version.... although json test implies it just continues
                                    throw InterpreterError.invalidVersion
                }
            } else {
                throw InterpreterError.invalidVersion
            }
            return uwReserved
        case .mClass, .mClassSH:
            try classManager.addClass(value)
            return .mClass
        case .objectIndex:
            let processed = try processModlElement(value)
            objectRefManager.addIndexedVariables(processed?.first)
            return uwReserved
        case .objectReference:
            var objPair = ModlOutputObject.Pair()
            objPair.key = uwKey
            objPair.value = try processModlElement(value)?.first
            objectRefManager.addKeyedVariable(key: objPair.key, value: objPair.value)
            return uwReserved
        case .load, .loadSH:
            return .load
        case .methodSH, .method:
            methodManager.addMethod(value)
            return .method
        }
    }
    
    private func processReferenceInstruction(key: String?, classIdsProcessedInBranch: [String]) -> ModlValue? {
        var outputValue: ModlValue? = nil
        guard var uwKey = key else {
            return nil
        }
        if uwKey.hasPrefix("%*") {
            uwKey.removeFirst()
        }
        guard let reservedType = ReservedKey(rawValue: uwKey.uppercased()) else {
            return nil
        }
        switch reservedType {
        case .load:
            outputValue = fileLoader.referenceInstruction()
        case .mClass:
            outputValue = classManager.referenceInstruction()
        case .method:
            outputValue = methodManager.referenceInstruction()
        default:
            return nil
        }
        return outputValue
    }
    
    private func processLoad(_ value: ModlValue?) throws -> [ModlValue]? {
        if let processedPath = try processModlElement(value)?.first {
            switch processedPath {
            case let primPath as ModlPrimitive:
                if let path = primPath.asString(), let obj = try? fileLoader.loadFileObject(path) { //TODO: how to fail?
                    var outputModl: [ModlValue] = []
                    for structure in obj.structures {
                        for processed in try processModlElement(structure) ?? [] {
                            outputModl.append(processed)
                        }
                    }
                    return [primPath]
                }
            case let arrPath as ModlArray:
                var outputModl: [ModlValue] = []
                for case let path as ModlPrimitive in arrPath.values {
                    if let path = path.asString(), let obj = try? fileLoader.loadFileObject(path) { //TODO: how to fail?
                        for structure in obj.structures {
                            for processed in try processModlElement(structure) ?? [] {
                                outputModl.append(processed)
                            }
                        }
                    }
                }
                return outputModl
            default:
                return nil
            }
        }
        return nil
    }

    func processConditional(_ conditional: ModlConditional) throws -> [ModlValue]? {
        var returnStructures: [ModlValue] = []
        var passedTest: Bool = false
        //nothing to return so return test value
        for (index, test) in conditional.conditionTests.enumerated() {
            if conditional.conditionReturns.count == 0 {
                var returnStruct = ModlOutputObject.Primitive()
                returnStruct.value = evaluateTest(test)
                returnStructures.append(returnStruct)
            } else if evaluateTest(test) {
                passedTest = true
                for structure in conditional.conditionReturns[index].structures {
                    if let value = try processModlElement(structure)?.first {
                        returnStructures.append(value)
                    }
                }
            }
         }
        if !passedTest {
            for structure in conditional.defaultReturn?.structures ?? [] {
                if let value = try processModlElement(structure)?.first {
                    returnStructures.append(value)
                }
            }
        }
        return returnStructures
    }
    
    func evaluateTest(_ testCondition: ModlConditionTest) -> Bool {
        var returnResult = true
        for subCondition in testCondition.subConditionList {
            var subConditionResult = true
            switch subCondition {
            case let condition as ModlCondition:
                subConditionResult = evaluateTest(condition)
            case let group as ModlConditionGroup:
                subConditionResult = evaluateTest(group)
            default:
                print("Error: Cannot find condition to evaluate")
                break
            }
            if let negate = subCondition.shouldNegate, negate {
                subConditionResult = !subConditionResult
            }
            switch subCondition.lastOperator {
            case "&":
                returnResult = subConditionResult && returnResult
            case "|":
                returnResult = subConditionResult || returnResult
            default:
                returnResult = subConditionResult
            }
        }
        return returnResult
    }
    
    func evaluateTest(_ condition: ModlCondition) -> Bool {
        guard let values = condition.values else {
            return false
        }
        
        //No key for condition so just a result to check i.e. no operator as no left side
        if condition.key == nil {
            //check if initially Bool value
            if let primBool = evaluatePrimitive(values.first) {
                return primBool
            }
            //Check if can be represented as a string
            if let primString = values.first as? ModlPrimitive, let stringValue = primString.asString() {
                //Check if can transform string to different Bool value
                if let transformed = stringTransformer.transformString(stringValue), let primBool = evaluatePrimitive(transformed) {
                    return primBool
                }
                //Check if there is a object reference for this value, and if it has a bool value
                if let refObj = objectRefManager.getKeyedVariable(stringValue) {
                    if let primBool = evaluatePrimitive(refObj) {
                        return primBool
                    }
                } else {
                    return false
                }
            }
            return true
        }

        //have a key, so LHS to check against RHS
        if let key = condition.key, let newKey = transformConditionalArguments(key), let operatorValue = condition.operatorType {
            //more than one value to check against, must be =, check if LHS = RHS for any value
            if values.count > 1 {
                for value in values {
                    if let pValue = (value as? ModlPrimitive)?.asString(), operatorValue == "=" {
                        let escaped = StringEscapeReplacer().replace(pValue)
                        if checkConditionalEquals(key: newKey, valueToCheck: escaped) {
                            return true
                        }
                        if let newValue = transformConditionalArguments(pValue) {
                            if checkConditionalEquals(key: newKey, valueToCheck: newValue) {
                                return true
                            }
                        }
                    }
                }
                return false
            } else if let firstValue = values.first {
            //only one value to check
                //Is it a bool?
                if let primBool = evaluatePrimitive(firstValue) {
                    return primBool
                }
                //Can it convert to a bool?
                if let originalStringValue = (firstValue as? ModlPrimitive)?.asString() {
                    let transformedStringValue = transformConditionalArguments(originalStringValue) ?? originalStringValue
                    if operatorValue == "=" {
                        if checkConditionalEquals(key: newKey, valueToCheck: transformedStringValue) {
                            return true
                        }
                        if checkConditionalEquals(key: newKey, valueToCheck: originalStringValue) {
                            return true
                        }
                        if let newStringValue = (stringTransformer.transformString(transformedStringValue) as? ModlPrimitive)?.asString(), checkConditionalEquals(key: newKey, valueToCheck: newStringValue) {
                            return true
                        }
                        if let newStringValue = (stringTransformer.transformString(originalStringValue) as? ModlPrimitive)?.asString(), checkConditionalEquals(key: newKey, valueToCheck: newStringValue) {
                            return true
                        }
                        return false
                    } else if operatorValue == "!=" {
                        return !checkConditionalEquals(key: newKey, valueToCheck: transformedStringValue)
                    } else if let doubleFirst = Double(newKey), let doubleSecond = Double(transformedStringValue) {
                        let expression = "\(doubleFirst) \(operatorValue) \(doubleSecond)"
                        let predicate = NSPredicate(format: expression)
                        return predicate.evaluate(with: nil)
                    }
                }
            }
        }
        return false
    }
    
    func evaluateTest(_ conditionGroup: ModlConditionGroup) -> Bool {
        var result = true
        for test in conditionGroup.conditionTests {
            let ctReturn = evaluateTest(test)
            switch test.lastOperator {
            case "&":
                result = ctReturn && result
            case "|":
                result = ctReturn || result
            default:
                result = ctReturn
            }
        }
        return result
    }
    
    func evaluatePrimitive(_ modlValue: ModlValue?) -> Bool? {
        guard let mPrim = modlValue as? ModlPrimitive, let pValue = mPrim.value as? Bool else {
            return nil
        }
        return pValue
    }
    
    func checkConditionalEquals(key: String?, valueToCheck: String?) -> Bool {
        guard let uwKey = key, let uwValue = valueToCheck else {
            return false
        }
        if uwValue.contains("*") {
            return checkWildcardConditionalEquals(key: uwKey, valueToCheck: uwValue)
        }
        let modifiedToCheck = uwValue.stripGraves()
        let modifiedKey = uwKey.stripGraves()
        return modifiedKey == modifiedToCheck
    }
    
    func checkWildcardConditionalEquals(key: String, valueToCheck: String) -> Bool {
        var regex = #""#
        regex += valueToCheck.hasPrefix("*") ? ".*" : "^"
//        let splits = valueToCheck.split(separator: "*")
        for (index, split) in valueToCheck.split(separator: "*").enumerated() {
            regex += index == 0 ? "" : ".*"
            regex += split
        }
        regex += valueToCheck.hasSuffix("*") ? ".*" : "$"
        return key.range(of: regex, options: .regularExpression) != nil
    }

    func transformConditionalArguments(_ originalKey: String) -> String? {
        var keyToCheck = originalKey
        if !keyToCheck.hasPrefix("%") {
            keyToCheck = "%"+keyToCheck
        }
        let transString = stringTransformer.transformString(keyToCheck)
        if let prim = transString as? ModlPrimitive, "%\(originalKey)" != prim.asString() {
            return prim.asString()
        }
        return nil
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
