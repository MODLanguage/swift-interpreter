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
//  MethodManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 07/06/2019.
//

import Foundation

fileprivate enum MethodSpecialKeys: String, CaseIterable {
    case identifier = "*id"
    case identifierSH = "*i"
    case name = "*name"
    case nameSH = "*n"
    case transform = "*transform"
    case transformSH = "*t"
}

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


internal class MethodManager {
    private var storedMethods: [String: Method] = [:]
    private var methodOrder: [String] = []
    private let subjectMethodInclusivePattern = #"((?<![\\~])`)([^`].+)((?<![\\~])`)(\.[a-zA-Z0-9_%]+(\([a-zA-Z,]*\))*)*"#
    private let methodPattern = #"(^|[0-9a-zA-Z])"#
    private let subjectPattern = #"((?<![\\~])`)([^`].+)((?<![\\~])`)"#

    func addMethod(_ method: ModlValue?) throws {
        guard let mMethod = Method(method) else {
            throw InterpreterError.invalidMethod
        }
        guard getMethod(mMethod.name) == nil, getMethod(mMethod.id) == nil else {
            throw InterpreterError.methodAlreadyDefined
        }
        storedMethods[mMethod.id] = mMethod
        methodOrder.append(mMethod.id)
    }
    
    private func getMethod(_ identifier: String?) -> Method? {
        guard let uwId = identifier else {
            return nil
        }
        return storedMethods.first(where: { (key, value) -> Bool in
            return value.name == uwId || key == uwId
        })?.value
    }
    
    func processStringForMethods(_ inputString: String?) -> String? {
        guard var uwInput = inputString else {
            return nil
        }
        var finished = false
        var startIndex = uwInput.startIndex
        while !finished {
            if let ref = getStringMethodsMatch(uwInput, start: startIndex) {
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

    private func getStringMethodsMatch(_ stringToTransform: String, start: String.Index) -> Range<String.Index>? {
        // Find all parts of the sting that are enclosed in graves and return with subsequent methods
        guard let regex = try? NSRegularExpression(pattern: subjectMethodInclusivePattern, options: []) else {
            return nil
        }
        return getPatternRange(inputString: stringToTransform, start: start, regEx: regex)
    }

    private func getSubjectMatch(inputString: String) -> Range<String.Index>? {
        guard let regex = try? NSRegularExpression(pattern: subjectPattern, options: []) else {
            return nil
        }
        return getPatternRange(inputString: inputString, start: inputString.startIndex, regEx: regex)
    }
    
    private func getPatternRange(inputString: String, start: String.Index, regEx: NSRegularExpression) -> Range<String.Index>? {
        let range = NSRange(start..., in: inputString)
        if let match = regEx.firstMatch(in: inputString, options: [], range: range) {
            return Range(match.range, in: inputString)
        }
        return nil
    }
    
    private func processStringMethods(inputString: String) -> String {
        guard let subjectRange = getSubjectMatch(inputString: inputString) else {
            return inputString
        }
        
        var subject = String(inputString[subjectRange.lowerBound..<subjectRange.upperBound])

        guard subject.count > 0 else {
            return inputString
        }

        let methodChain = inputString[subjectRange.upperBound...]
        //        var methods = methodChain.split(separator: ".").map({String($0)})
        var methods: [String] = []
        var output = ""
        var inBrackets = false
        for char in methodChain {
            if char == "." && !inBrackets {
                if output.count > 0  {
                    methods.append(output)
                    output = ""
                }
                continue
            }else if char == "(" {
                inBrackets = true
            } else if char == ")" {
                inBrackets = false
            }
            output.append(char)
        }
        if output.count > 0 {
            methods.append(output)
        }
        guard methods.count > 0 else {
            return inputString
        }
        
        for (index,method) in methods.enumerated() {
            if let customTransformed = performCustomStringMethod(subject, customMethodId: method) {
                subject = customTransformed
            } else if let transformed = performStringMethod(inputString: subject, stringMethodName: method) {
                subject = transformed
            } else {
                let remaining = methods[index...]
                for rMethod in remaining {
                    subject = subject + "." + rMethod
                }
                break
            }
        }
        return subject
    }
    
    private func performCustomStringMethod(_ inputStr: String, customMethodId: String) -> String? {
        var methodIdent = customMethodId
        if methodIdent.hasSuffix("`") {
            methodIdent.removeLast()
        }

        guard let method = getMethod(methodIdent) else {
            return nil
        }
        let newInput = "\(inputStr).\(method.transformChain)"
        return processStringMethods(inputString: newInput)
    }

    private func performStringMethod(inputString: String?, stringMethodName: String) -> String? {
        guard let sMethod = StringMethod(rawValue: stringMethodName), let uwStr = inputString?.stripGraves() else {
            return nil
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
    
    func referenceInstruction() -> ModlOutputObject.Array {
        let methodArr = methodOrder.compactMap({ (methodId) -> ModlValue? in
            if let mMethod = storedMethods[methodId] {
                return mMethod.referenceInstruction()
            }
            return nil
        })
        var output = ModlOutputObject.Array()
        output.values = methodArr
        return output
    }

}

fileprivate struct Method {
    let id: String
    let name: String
    let transformChain: String
    
    init?(_ map: ModlValue?) {
        guard let methodMap = map as? ModlMap else {
            return nil
        }
        if let methodId = (methodMap.value(forKeys: ["*i", "*id"], ignoreCase: true) as? ModlPrimitive)?.asString(),
            var methodChain = (methodMap.value(forKeys: ["*t", "*transform"], ignoreCase: true) as? ModlPrimitive)?.asString() {
            id = methodId
            name = (methodMap.value(forKeys: ["*n", "*name"], ignoreCase: true) as? ModlPrimitive)?.asString() ?? methodId
            if methodChain.hasPrefix("`") {
                methodChain.removeFirst()
            }
            if methodChain.hasSuffix("`") {
                methodChain.removeLast()
            }
            transformChain = methodChain //TODO: better handling of empty replace method
        } else {
            return nil
        }
    }
    
    func referenceInstruction() -> ModlOutputObject.Pair {
        var pair = ModlOutputObject.Pair()
        var map = ModlOutputObject.Map()
        map.addValue(key: "name", value: ModlOutputObject.Primitive(name))
        map.addValue(key: "transform", value: ModlOutputObject.Primitive(transformChain.replacingOccurrences(of: ", )", with: ",)")))
        pair.key = id
        pair.value = map
        return pair
    }


}
