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
//  ModlObjectProtocols.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.

import Foundation

protocol ModlObject: AnyObject {
    var structures: [ModlStructure] {get set}
}

extension ModlObject {
    func addStructure(_ structure: ModlStructure) {
        self.structures.append(structure)
    }
}
protocol ModlValue {}
protocol ModlStructure: ModlValue {}
protocol ModlPair: ModlStructure {
    var key: String? {get set}
    var value: ModlValue? {get set}
}

protocol ModlArray: ModlStructure {
    var values: [ModlValue] {get set}
    mutating func addValue(_ value: ModlValue)
}

protocol ModlMap: ModlStructure {
    var values: [String: ModlValue] {get set}
    var orderedKeys: [String] {get set}
    mutating func addValue(key: String, value: ModlValue)
}

protocol ModlPrimitive: ModlValue {
    var value: Any? {get set}
    mutating func setValue(value: Any?)
}

extension ModlPrimitive {
    func asString() -> String? {
        switch value {
        case let int as Int:
            return String(int)
        case let dec as Decimal:
            return "\(dec)"
        case let str as String:
            return str
        default:
            return nil
        }
    }
}

protocol ModlNull: ModlValue {}

extension ModlMap {
    mutating func addValue(key: String, value: ModlValue) {
        values[key] = value
        orderedKeys.append(key)
    }
    
    func value(forKey key: String, ignoreCase: Bool = false) -> ModlValue? {
        if ignoreCase {
            for (vKey,value) in values {
                if vKey.lowercased() == key.lowercased() {
                    return value
                }
            }
            return nil
        } else {
            return values[key]
        }
    }
    
    func value(forKeys keys: [String], ignoreCase: Bool = false) -> ModlValue? {
        for key in keys {
            if let value = value(forKey: key, ignoreCase: ignoreCase) {
                return value
            }
        }
        return nil
    }
}

protocol ModlConditionTest {}
protocol ModlCondition {}
protocol ModlSubCondition {}
protocol ModlConditionGroup {}


protocol ModlTopLevelConditional: ModlStructure {
    var returns: [(ModlConditionTest, ModlTopLevelConditionalReturn)] {get set}
}

protocol ModlTopLevelConditionalReturn: ModlStructure {
    var structures: [ModlStructure] {get set}
}

