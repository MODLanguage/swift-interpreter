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
//  ModlListenerObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import Foundation

internal class ModlListenerObject: ModlObject {
    var structures: [ModlStructure] = []
    
    struct Pair: ModlPair {
        var key: String?
        var value: ModlValue?
    }
    
    struct Array: ModlArray {
        mutating func addValue(_ value: ModlValue) {
            self.values.append(value)
        }
        
        var values: [ModlValue] = []
    }
    
    struct Map: ModlMap {
//        var conditionals: [MapConditional] = []
        var values: [String : ModlValue] = [:]
        var orderedKeys: [String] = []
        
        mutating func addConditional(_ conditional: MapConditional) {
            let randomKey = UUID().uuidString
            addValue(key: randomKey, value: conditional)
        }
    }
    
    struct MapItem: ModlMapItem {
        var key: String?
        var value: ModlValue?
        
        init?(pair: ModlPair) {
            self.key = pair.key
            self.value = pair.value
        }
    }
    
    struct Null: ModlNull {
    }
    
    struct Primitive: ModlPrimitive {
        mutating func setValue(value: Any?) {
            self.value = value
        }
        
        var value: Any?
    }
    
    struct TopLevelConditional: ModlTopLevelConditional {
        var defaultReturn: ModlConditionalReturn?
        var conditionReturns: [ModlConditionalReturn] = []
        var conditionTests: [ModlConditionTest] = []
        
        mutating func addTestAndReturn(testCase: ModlConditionTest, conditionalReturn: ModlTopLevelConditionalReturn) {
            //TODO: check indexes
            conditionReturns.append(conditionalReturn)
            conditionTests.append(testCase)
        }
    }
    
    struct TopLevelConditionalReturn: ModlTopLevelConditionalReturn {
        mutating func addStructure(_ structure: ModlStructure) {
            self.structures.append(structure)
        }
        
        public private(set) var structures: [ModlValue] = []
    }
    
    struct MapConditional: ModlMapConditional {
        var conditionReturns: [ModlConditionalReturn] = []
        var defaultReturn: ModlConditionalReturn?
        var conditionTests: [ModlConditionTest] = []
    }

    struct MapConditionalReturn: ModlMapConditionalReturn {
        public private(set) var structures: [ModlValue] = []
        mutating func addItem(_ structure: ModlMapItem) {
            self.structures.append(structure)
        }
    }
    
    struct ArrayConditional: ModlArrayConditional {
        var conditionReturns: [ModlConditionalReturn] = []
        var conditionTests: [ModlConditionTest] = []
        var defaultReturn: ModlConditionalReturn?
    }
    
    struct ArrayConditionalReturn: ModlArrayConditionalReturn {
        mutating func addItem(_ structure: ModlValue) {
            self.structures.append(structure)
        }
        
        public private(set) var structures: [ModlValue] = []
    }
    
    struct ValueConditional: ModlValueConditional {
        var conditionReturns: [ModlConditionalReturn] = []
        var conditionTests: [ModlConditionTest] = []
        var defaultReturn: ModlConditionalReturn?
    }
    
    struct ValueConditionalReturn: ModlValueConditionalReturn {
        mutating func addItem(_ structure: ModlValue) {
            self.structures.append(structure)
        }
        
        public private(set) var structures: [ModlValue] = []
    }

    struct ConditionTest: ModlConditionTest {
        var lastOperator: String? = nil
        var subConditionList: [ModlSubCondition] = []
    }
    
    struct ConditionGroup: ModlConditionGroup {
        var shouldNegate: Bool?
        var lastOperator: String?
        var conditionTests: [ModlConditionTest]
    }
    
    struct Condition: ModlCondition {
        var key: String?
        var operatorType: String?
        var values: [ModlValue]?
        
        var shouldNegate: Bool?
        var lastOperator: String?
    }
}
