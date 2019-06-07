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
//  StringTransformer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 13/05/2019.
//

import Foundation
import Punycode

struct StringTransformer {
    let gravesPatternStart = #"(?<![\~])`[^`]+"#
    let gravePatternEnd = #"(?<![\~])`"#
    let numberRefPatternStart = #"`?%[0-9]+"#
    let refPatternEnd = #"`?"#
    let valueRefPatternStart = #"`?%[a-zA-Z_]+[_a-zA-Z0-9]*"#
    let methodPattern = #"(\.[a-zA-Z0-9_%]+(\([a-zA-Z,]*\))*)*"#

    let objectManager: ModlObjectReferenceManager
    let methodManager: MethodManager

    init(objectManager: ModlObjectReferenceManager, methodManager: MethodManager) {
        self.objectManager = objectManager
        self.methodManager = methodManager
    }
    
    func transformKeyString(_ inputString: String?) -> String? {
        let prim = transformString(inputString) as? ModlPrimitive
        let output = prim?.value as? String ?? inputString
        return processStringForMethods(output)
    }
    
    func transformString(_ inputString: String?) -> ModlValue? {
        guard var uwInput = inputString else {
            //TODO: Return ModlNull?
            return nil
        }
        var prim = ModlOutputObject.Primitive()

    //*** Check if bool value
        if uwInput.lowercased() == "true" {
            prim.value = true
            return prim
        } else if uwInput.lowercased() == "false" {
            prim.value = false
            return prim
        }


    //*** Escape as per string-replacement.txt
        //TODO: is this necessary?
        uwInput = StringEscapeReplacer().replace(uwInput)
    //*** Replace Unicode:
        //TODO: swift might make this unnec

        if refContinueQuickProcess(inputString) == nil {
            prim.value = uwInput
            return prim
        }
        
        var startIndex: String.Index = uwInput.startIndex
        var finished = false
        while !finished {
            if let ref = getObjectRangesMatch(uwInput, start: startIndex) {
                let refKey = String(uwInput[ref])
                let mValue = checkObjectReferencing(keyToCheck: refKey, objectMgr: objectManager)
                if refKey == uwInput {
                    //the entire key matches the grave key so just return referenced object
                    return mValue
                } else if let primitive = mValue as? ModlPrimitive, let replacement = primitive.asString() {
                    //need to get prim value of returned item and replace grave parts with it
                    uwInput = uwInput.replacingCharacters(in: ref, with: replacement)
                    startIndex = uwInput.index(ref.lowerBound, offsetBy: replacement.distance(from: replacement.startIndex, to: replacement.endIndex))
                } else {
                    
                    //TODO: is there anything else that can happen? Can part of a string in graves become an array?
                }
                if startIndex == ref.lowerBound {
                    finished = true
                } 
                if mValue == nil {
                    finished = true
                }
            } else {
                finished = true
            }
        }

        prim.value = uwInput
        return prim
    }
    
    private func refContinueQuickProcess(_ inputString: String?) -> String? {
        guard let uwStr = inputString, uwStr.contains("%") || uwStr.contains("`")  else {
            return nil
        }
        return uwStr
    }
    
    private func getObjectRangesMatch(_ stringToTransform: String, start: String.Index) -> Range<String.Index>? {
        // Find all parts of the sting that are enclosed in graves, e.g `test` where neither of the graves is prefixed with an escape character ~ (tilde) or \ (backslash). Or that have a %
        let completePattern = "(\(gravesPatternStart)\(methodPattern)\(gravePatternEnd)|\(numberRefPatternStart)\(methodPattern)\(refPatternEnd)|\(valueRefPatternStart)\(methodPattern)\(refPatternEnd))\(methodPattern)"
        let regex = try? NSRegularExpression(pattern: completePattern, options: [])
        let range = NSRange(start..., in: stringToTransform)
        if let match = regex?.firstMatch(in: stringToTransform, options: [], range: range) {
            return Range(match.range, in: stringToTransform)
        }
        return nil
    }
    
    private func getStringMethodsMatch(_ stringToTransform: String, start: String.Index) -> Range<String.Index>? {
        // Find all parts of the sting that are enclosed in graves and return with subsequent methods
        let completePattern = "(\(gravesPatternStart)\(gravePatternEnd)|\(numberRefPatternStart)\(methodPattern)\(refPatternEnd)|\(valueRefPatternStart)\(methodPattern)\(refPatternEnd))\(methodPattern)"
        let regex = try? NSRegularExpression(pattern: completePattern, options: [])
        let range = NSRange(start..., in: stringToTransform)
        if let match = regex?.firstMatch(in: stringToTransform, options: [], range: range) {
            return Range(match.range, in: stringToTransform)
        }
        return nil
    }

    private func checkObjectReferencing(keyToCheck: String, objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
        guard let uwObjMgr = objectMgr, var mKey = refContinueQuickProcess(keyToCheck) else {
            return nil
        }
        if mKey.hasPrefix("`") {
            mKey.removeFirst()
        }
        if mKey.hasPrefix("%") {
            mKey.removeFirst()
        } else {
            return nil
        }
        if mKey.hasSuffix("`") {
            mKey.removeLast()
        }
        
        guard mKey.count > 0 else {
            return nil
        }

        var methods = mKey.split(separator: ".").map{String($0)}
        var subject = String(methods.remove(at: 0)) //take off the subject and leave the methods
        if subject.hasSuffix("`") {
            subject.removeLast()
        }
        var refObject: ModlValue?
        if let numReference = Int(subject) {
            refObject = uwObjMgr.getIndexedVariable(numReference)
        } else {
            refObject = objectMgr?.getKeyedVariable(subject)
        }
        var returnObject = refObject
        if methods.count != 0 {
            returnObject = handleNestedObject(refObject, methods: methods, objectMgr: objectMgr)
        }
        if var primObj = returnObject as? ModlPrimitive, var strValue = primObj.value as? String {
            if !strValue.hasPrefix("`") {
                strValue = "`\(strValue)"
            }
            if !strValue.hasSuffix("`") {
                strValue = "\(strValue)`"
            }
            strValue = processStringForMethods(strValue) ?? ""
            primObj.setValue(value: strValue)
            returnObject = primObj
        }
        return returnObject
    }

    
    private func handleNestedObject(_ refObject: ModlValue?, methods: [String], objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
        var newRef = refObject
        var index = 0
        var isFinished = index >= methods.count
        
        while !isFinished {
            var method = String(methods[index])
            if let transformed = transformString(method) as? ModlPrimitive {
                method = transformed.asString() ?? method
            }
            if let numMethod = Int(method), let refArray = newRef as? ModlArray {
                newRef = refArray.values[numMethod]
            } else if let refMap = newRef as? ModlMap {
                newRef = refMap.value(forKey: method)
            } else if let refPair = newRef as? ModlPair, refPair.key == method {
                newRef = refPair.value
            } else if var refPrim = newRef as? ModlPrimitive, var primValue = refPrim.asString() {
                let methodChain = methods[index...].joined(separator: ".")
                if methodChain.count > 0 {
                    primValue = primValue + "." + methodChain
                }
                refPrim.setValue(value: primValue)
                newRef = refPrim
                isFinished = true
                continue
            }
            
            index += 1
            isFinished = index >= methods.count
        }
        return newRef
    }
    

    func processStringForMethods(_ inputString: String?) -> String? {
        guard var uwInput = inputString else {
            return nil
        }
        var finished = false
        var startIndex = uwInput.startIndex
        while !finished {
            if let ref = getObjectRangesMatch(uwInput, start: startIndex) {
                let testableString = String(uwInput[ref])
                var replacement = methodManager.processStringMethods(inputString: testableString)
                if replacement.hasPrefix("`") {
                    replacement.removeFirst()
                }
                if replacement.hasSuffix("`") {
                    replacement.removeLast()
                }
                uwInput = uwInput.replacingCharacters(in: ref, with: replacement)
                startIndex = uwInput.index(ref.lowerBound, offsetBy: replacement.distance(from: replacement.startIndex, to: replacement.endIndex))
                if startIndex == ref.lowerBound {
                    finished = true
                }
            } else {
//                uwInput = processStringMethods(inputString: uwInput)
                finished = true
            }
        }
        return uwInput
    }
        
}
