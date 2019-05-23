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

fileprivate enum StringMethod {
    case uppercase
    case downcase
    case sentenceCase
    case initCap
    case urlencode
    case puny
    case replace(_ existing: String, _ replacement: String)
    case trim(_ reference: String)
    
    init?(rawValue: String) {
        guard let first = rawValue.first else {
            return nil
        }
        switch first {
        case "u":
            self = .uppercase
        case "d":
            self = .downcase
        case "s":
            self = .sentenceCase
        case "i":
            self = .initCap
        case "e":
            self = .urlencode
        case "p":
            self = .puny
        case "r":
            guard let find = rawValue.slice(from: "(", to: ","),
                let replace = rawValue.slice(from: ",", to: ")") else {
                    return nil
            }
            self = .replace(find, replace)
        case "t":
            guard let reference = rawValue.slice(from: "(", to: ")") else {
                return nil
            }
            self = .trim(reference)
        default:
            return nil
        }
    }
}

struct StringTransformer {
    let objectRegExPattern = "((`?\\%[0-9][0-9.][a-zA-Z0-9.(),]*`?)|(`?\\%[0-9][0-9]*`?)|(`?\\%[_a-zA-Z][_a-zA-Z0-9.%(),]*`?)|(`.*`\\.[_a-zA-Z0-9.(),%]+)|(`.*`))"

    func transformKeyString(_ inputString: String?, objectMgr: ModlObjectReferenceManager?) -> String? {
        let prim = transformString(inputString, objectMgr: objectMgr) as? ModlPrimitive
        let output = prim?.value as? String ?? inputString
        return processStringForMethods(output)
    }
    
    func transformString(_ inputString: String?, objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
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
                let mValue = checkObjectReferencing(keyToCheck: refKey, objectMgr: objectMgr)
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
        prim.value = uwInput//.replacingOccurrences(of: "`", with: "")
        return prim
    }
    
    private func refContinueQuickProcess(_ inputString: String?) -> String? {
        guard let uwStr = inputString, uwStr.contains("%") || uwStr.contains("`")  else {
            return nil
        }
        return uwStr
    }
    
    private func getObjectRangesMatch(_ stringToTransform: String, start: String.Index) -> Range<String.Index>? {
        // Find all parts of the sting that are enclosed in graves, e.g `test` where neither of the graves is prefixed with an escape character ~ (tilde) or \ (backslash).
        let regex = try? NSRegularExpression(pattern: objectRegExPattern, options: [])
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
        let subject = String(methods.remove(at: 0)) //take off the subject and leave the methods
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
            if let transformed = transformString(method, objectMgr: objectMgr) as? ModlPrimitive {
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
                var replacement = processStringMethods(inputString: testableString)
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
        
    private func processStringMethods(inputString: String) -> String {
        var methods = inputString.split(separator: ".").map({String($0)})
        guard methods.count > 1 else {
            return inputString
        }
        var subject: String = String(methods.remove(at: 0)) //take off the subject and leave the methods
        if subject.hasPrefix("`") {
            subject.removeFirst()
        }
        if subject.hasSuffix("`") {
            subject.removeLast()
        }
        for method in methods {
            subject = performStringMethod(inputString: subject, stringMethodName: method)
        }
        return subject
    }
    
    private func performStringMethod(inputString: String?, stringMethodName: String) -> String {
        guard let sMethod = StringMethod(rawValue: stringMethodName), let uwStr = inputString else {
            return (inputString ?? "") + "." + stringMethodName
        }
        switch sMethod {
        case .downcase:
            return uwStr.lowercased()
        case .uppercase:
             return uwStr.uppercased()
        case .initCap:
            return initCapIgnoringUnderscore(uwStr)
        case .sentenceCase:
            return uwStr.replacingCharacters(in: uwStr.startIndex...uwStr.startIndex, with: String(uwStr[uwStr.startIndex].uppercased()))
        case .replace(let find, let replace):
            return uwStr.replacingOccurrences(of: find, with: replace)
        case .urlencode:
            return urlPercentEncode(uwStr)
        case .trim(let reference):
            return trimStringToRef(input: uwStr, ref: reference)
        case .puny:
            return uwStr.punycodeDecoded ?? ""
        }
//        return uwStr + "." + stringMethodName
    }
    
    private func urlPercentEncode(_ inputString: String) -> String {
        let spaceString = inputString.replacingOccurrences(of: " ", with: "+")
        let unreserved = "-._~/?+"
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: unreserved)
        return spaceString.addingPercentEncoding(withAllowedCharacters: allowed) ?? spaceString
    }
    
    private func initCapIgnoringUnderscore(_ inputString: String) -> String {
        let words = inputString.split(separator: " ")
        let reduced = words.reduce("") { (result, string) -> String in
            var output = result
            if result.count > 0 {
                output = output + " "
            }
            return output + string.replacingCharacters(in: string.startIndex...string.startIndex, with: String(string[string.startIndex].uppercased()))
        }
        return reduced //.initcap also capitalises underscore words so cannot use
    }
    
    private func trimStringToRef(input: String, ref: String) -> String {
        if let range = input.range(of: ref)?.lowerBound {
            return String(input[..<range])
        }
        return input
    }
}
