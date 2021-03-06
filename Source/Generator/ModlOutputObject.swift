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
//  ModlObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//

import Foundation

internal protocol ModlJSON {
    func asJson() -> String?
}

internal class ModlOutputObject: ModlObject, ModlJSON {
    func asJson() -> String? {
        var reducedArray = structures.reduce("") { (result, nextValue) -> String in
            if let next = (nextValue as? ModlJSON)?.asJson() {
                return result + "\(next),"
            } else {
                return result
            }
        }
        if reducedArray.count > 0 {
            reducedArray = String(reducedArray.dropLast())
        }
        if structures.count == 0 {
            return "null"
        }else if structures.count == 1 {
            return reducedArray
        } else {
            return "[\(reducedArray)]"
        }
    }
    
    var structures: [ModlStructure] = []
    
    struct Pair: ModlPair, ModlJSON {
        func asJson() -> String? {
            guard let uwKey = key?.stripGraves(), let uwValue = (value as? ModlJSON)?.asJson() else {
                return nil
            }
            return "{\"\(uwKey)\":\(uwValue)}"
        }
        
        var key: String?
        var value: ModlValue?
    }
    
    struct Array: ModlArray, ModlJSON {
        var values: [ModlValue] = []
        func asJson() -> String? {
            var reducedArray = values.reduce("") { (result, nextValue) -> String in
                if let next = (nextValue as? ModlJSON)?.asJson() {
                    return result + "\(next),"
                } else {
                    return result
                }
            }
            if reducedArray.count > 0 {
                reducedArray = String(reducedArray.dropLast())
            }
            return "[\(reducedArray)]"
        }
        
        mutating func addValue(_ value: ModlValue) {
            values.append(value)
        }
    }
    
    struct Map: ModlMap, ModlJSON {
        var conditionals: [ModlMapConditionalReturn] = []
        
        var values: [String : ModlValue] = [:]
        var orderedKeys: [String] = []
        
        func asJson() -> String? {
            var out = ""
            for key in orderedKeys {
                if values.keys.contains(key) {
                    out += "\"\(key.stripGraves())\":\((values[key] as? ModlJSON)?.asJson() ?? ""),"
                }
            }
            return "{" + out.dropLast() + "}"
        }
    }
    
    struct Null: ModlNull, ModlJSON {
        func asJson() -> String? {
            return "null"
        }
    }
    
    struct Primitive: ModlPrimitive, ModlJSON {
        
        init() {
        }
        
        init(_ strValue: String) {
            self.value = strValue
        }
        
        mutating func setValue(value: Any?) {
            self.value = value
        }
        
        var value: Any?
        
        func asJson() -> String? {
            if var uwString = value as? String {
                uwString = uwString.replacingOccurrences(of: "\"", with: "\\\"")
                if uwString.hasSuffix("\"") && uwString.hasPrefix("\""){
                    return uwString
                }
                if uwString.hasSuffix("`") && uwString.hasPrefix("`"){
                    let indexStartOfText = uwString.index(uwString.startIndex, offsetBy: 1)
                    let indexEndOfText = uwString.index(uwString.endIndex, offsetBy: -1)
                    uwString = String(uwString[indexStartOfText..<indexEndOfText])
                }

                return "\"\(uwString)\""
            } else if let uwBool = value as? Bool {
                return uwBool ? "true" : "false"
            } else if let uwNumber = value as? Decimal {
                return "\(uwNumber)"
            } else if let uwNumber = value as? Float {
                return "\(uwNumber)"
            } else if let uwNumber = value as? Int64 {
                return "\(uwNumber)"
            }
            return nil
        }
    }
    
}
