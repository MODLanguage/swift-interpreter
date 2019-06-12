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

internal protocol ModlObject: AnyObject {
    var structures: [ModlStructure] {get set}
}

internal protocol ModlValue {}
internal protocol ModlStructure: ModlValue {}
internal protocol ModlPair: ModlStructure {
    var key: String? {get set}
    var value: ModlValue? {get set}
}


internal protocol ModlArray: ModlStructure {
    var values: [ModlValue] {get set}
    mutating func addValue(_ value: ModlValue)
}

internal protocol ModlArrayItem: ModlValue {}

internal protocol ModlMap: ModlStructure {
    var values: [String: ModlValue] {get set}
    var orderedKeys: [String] {get set}
    mutating func addValue(_ mapItem: ModlMapItem)
}

internal protocol ModlMapItem: ModlPair {
    init?(pair: ModlPair)
}

internal protocol ModlPrimitive: ModlValue {
    var value: Any? {get set}
    mutating func setValue(value: Any?)
}

internal protocol ModlNull: ModlValue {}


/*****/
//Condition Details
/*****/
internal protocol ModlConditionTest: ModlLastOperator {
    var subConditionList: [ModlSubCondition] {get set}
}

internal protocol ModlCondition: ModlSubCondition {
    var key: String? {get set}
    var operatorType: String? {get set}
    var values: [ModlValue]? {get set}
}

internal protocol ModlConditionGroup: ModlSubCondition {
    var conditionTests: [ModlConditionTest] {get set} //TODO: this can be improved, too many tuples
}

internal protocol ModlSubCondition: ModlLastOperator, ModlConditionNegatable {}

internal protocol ModlLastOperator {
    var lastOperator: String? {get set}
}

internal protocol ModlConditionNegatable {
    var shouldNegate: Bool? {get set}
}

/*****/
//Conditionals
/*****/
internal protocol ModlConditional: ModlStructure {
    var conditionReturns: [ModlConditionalReturn] {get set}
    var conditionTests: [ModlConditionTest] {get set}
    var defaultReturn: ModlConditionalReturn? {get set}
    mutating func addTestAndReturn(testCase: ModlConditionTest?, conditionalReturn: ModlConditionalReturn?)
}

internal extension ModlConditional {
    mutating func addTestAndReturn(testCase: ModlConditionTest?, conditionalReturn: ModlConditionalReturn?) {
        if let uwTest = testCase {
            if let uwReturn = conditionalReturn {
                conditionReturns.append(uwReturn)
            }
            conditionTests.append(uwTest)
        } else {
            defaultReturn = conditionalReturn
        }
    }
}

internal protocol ModlTopLevelConditional: ModlConditional {}
internal protocol ModlMapConditional: ModlConditional {}
internal protocol ModlArrayConditional: ModlConditional {}
internal protocol ModlValueConditional: ModlConditional {}

/*****/
//ConditionalReturns
/*****/
internal protocol ModlConditionalReturn: ModlStructure {
    var structures: [ModlValue] {get}
}

internal protocol ModlTopLevelConditionalReturn: ModlConditionalReturn {
    mutating func addStructure(_ structure: ModlStructure)
}

internal protocol ModlMapConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlMapItem)
}

internal protocol ModlArrayConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlValue)
}

internal protocol ModlValueConditionalReturn: ModlConditionalReturn {
    mutating func addItem(_ structure: ModlValue)
}

//EXTENSIONS
internal extension ModlObject {
    func addStructure(_ structure: ModlStructure) {
        self.structures.append(structure)
    }
}

internal extension ModlPrimitive {
    func asString() -> String? {
        switch value {
        case let int as Int:
            return String(int)
        case let dec as Decimal:
            return "\(dec)"
        case let str as String:
            return str
        case let bool as Bool:
            if bool {
                return "true"
            } else {
                return "false"
            }
        default:
            return nil
        }
    }
    
    func asNumber() -> Decimal? {
        switch value {
        case let int as Int:
            return Decimal(integerLiteral: int)
        case let dec as Decimal:
            return dec
        case let str as String:
            return Decimal(string: str)
        case let bool as Bool:
            if bool {
                return 1
            } else {
                return 0
            }
        default:
            return nil
        }
    }
}


internal extension ModlMap {
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
