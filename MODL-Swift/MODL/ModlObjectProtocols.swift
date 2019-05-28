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

protocol ModlArrayItem: ModlValue {}

protocol ModlMap: ModlStructure {
    var values: [String: ModlValue] {get set}
    var orderedKeys: [String] {get set}
    mutating func addValue(_ mapItem: ModlMapItem)
}

protocol ModlMapItem: ModlPair {
    init?(pair: ModlPair)
}

protocol ModlPrimitive: ModlValue {
    var value: Any? {get set}
    mutating func setValue(value: Any?)
}

protocol ModlNull: ModlValue {}


/*****/
//Condition Details
/*****/
protocol ModlConditionTest {
    var subConditionList: [ModlSubCondition] {get set}
}

protocol ModlCondition: ModlSubCondition {
    var key: String? {get set}
    var operatorType: String? {get set}
    var values: [ModlValue]? {get set}
}

protocol ModlConditionGroup: ModlSubCondition {
    var conditionTests: [(ModlConditionTest, String)] {get set} //TODO: this can be improved, too many tuples
}

protocol ModlSubCondition {
    var shouldNegate: Bool? {get set}
    var lastOperator: String? {get set}
}

/*****/
//Conditionals
/*****/
protocol ModlConditional: ModlStructure {
    associatedtype ConditionalReturn
    init()
    var conditionReturns: [ConditionalReturn] {get set}
    var conditionTests: [ModlConditionTest] {get set}
    var defaultReturn: ConditionalReturn? {get set}
    mutating func addTestAndReturn(testCase: ModlConditionTest?, conditionalReturn: ConditionalReturn)
}

extension ModlConditional {
    mutating func addTestAndReturn(testCase: ModlConditionTest?, conditionalReturn: ConditionalReturn) {
        if let uwTest = testCase {
            conditionReturns.append(conditionalReturn)
            conditionTests.append(uwTest)
        } else {
            defaultReturn = conditionalReturn
        }
    }
}

protocol ModlTopLevelConditional: ModlConditional {}
protocol ModlMapConditional: ModlConditional {}
protocol ModlArrayConditional: ModlConditional {}
protocol ModlValueConditional: ModlConditional {}

/*****/
//ConditionalReturns
/*****/
protocol ModlConditionalReturn: ModlStructure {
    var structures: [ModlValue] {get}
}

protocol ModlTopLevelConditionalReturn: ModlConditionalReturn {
    mutating func addStructure(_ structure: ModlStructure)
}

protocol ModlMapConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlMapItem)
}

protocol ModlArrayConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlValue)
}

protocol ModlValueConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlValue)
}

//EXTENSIONS
extension ModlObject {
    func addStructure(_ structure: ModlStructure) {
        self.structures.append(structure)
    }
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


extension ModlMap {
    mutating func addValue(_ mapItem: ModlMapItem) {
        guard let uwKey = mapItem.key, let uwValue = mapItem.value else {
            return
        }
        values[uwKey] = uwValue
        orderedKeys.append(uwKey)
    }
    
    mutating func addValue(key: String, value: ModlValue) {
//        guard let uwKey = mapItem.key, let uwValue = mapItem.value else {
//            return
//        }
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
