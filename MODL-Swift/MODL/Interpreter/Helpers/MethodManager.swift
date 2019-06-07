//
//  MethodManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 07/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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


class MethodManager {
    private var storedMethods: [String: Method] = [:]
    private var methodOrder: [String] = []

    func addMethod(_ method: ModlValue?) {
        if let mMethod = Method(method) {
            storedMethods[mMethod.id] = mMethod
            methodOrder.append(mMethod.id)
        }
    }
    
    private func getMethod(_ identifier: String?) -> Method? {
        guard let uwId = identifier else {
            return nil
        }
        return storedMethods.first(where: { (key, value) -> Bool in
            return value.name == uwId || key == uwId
        })?.value
    }
    
    func processStringMethods(inputString: String) -> String {
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
        guard let sMethod = StringMethod(rawValue: stringMethodName), let uwStr = inputString else {
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
            transformChain = methodChain.replacingOccurrences(of: ", )", with: ",)") //TODO: better handling of empty replace method
        } else {
            return nil
        }
    }
    
    func referenceInstruction() -> ModlOutputObject.Pair {
        var pair = ModlOutputObject.Pair()
        var map = ModlOutputObject.Map()
        map.addValue(key: "name", value: ModlOutputObject.Primitive(name))
        map.addValue(key: "transform", value: ModlOutputObject.Primitive(transformChain))
        pair.key = id
        pair.value = map
        return pair
    }


}
