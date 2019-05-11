//
//  ModlObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

protocol ModlJSON {
    func asJson() -> String?
}

class ModlOutputObject: ModlObject, ModlJSON {
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
        if structures.count == 1 {
            return reducedArray
        } else {
            return "[\(reducedArray)]"
        }
    }
    
    var structures: [ModlStructure] = []
    
    class Pair: ModlPair, ModlJSON {
        func asJson() -> String? {
            guard let uwKey = key, let uwValue = (value as? ModlJSON)?.asJson() else {
                return nil
            }
            return "{\"\(uwKey)\":\(uwValue)}"
        }
        
        var key: String?
        var value: ModlValue?
    }
    
    class Array: ModlArray, ModlJSON {
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
    }
    
    class Map: ModlMap, ModlJSON {
        var values: [String : ModlValue] = [:]
        var orderedKeys: [String] = []
        
        func asJson() -> String? {
            var out = ""
            for key in orderedKeys {
                if values.keys.contains(key) {
                    out += "\"\(key)\":\((values[key] as? ModlJSON)?.asJson() ?? ""),"
                }
            }
            return "{" + out.dropLast() + "}"
        }
    }
    
    class Null: ModlNull, ModlJSON {
        func asJson() -> String? {
            return "null"
        }
    }
    
    class Primitive: ModlPrimitive, ModlJSON {
        var value: Any?
        
        func asJson() -> String? {

            if let uwString = value as? String {
                return "\"\(NSRegularExpression.escapedPattern(for: uwString))\""
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
