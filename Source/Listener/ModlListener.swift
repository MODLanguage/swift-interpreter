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
//  ModlListener.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import Foundation
import Antlr4


class ModlListener: MODLParserBaseListener {
    
    static let ModlVersion = 1.0 // included version of MODL grammer
    
    var object = ModlListenerObject()
    var parseError: Error?
    
    func parseModl() {
        
    }
    
    override func enterModl(_ ctx: MODLParser.ModlContext) {
        parseError = nil
        for mStructure in ctx.modl_structure() {
            if let structure = processStructure(mStructure) {
                object.addStructure(structure)
            }
        }
    }
    
    func processStructure(_ ctx: MODLParser.Modl_structureContext) -> ModlStructure? {
        if let pair = ctx.modl_pair() {
            return processPair(pair)
        } else if let conditional = ctx.modl_top_level_conditional() {
            return processTopLevelConditional(conditional)
        } else if let map = ctx.modl_map() {
            return processMap(map)
        } else if let array = ctx.modl_array() {
            return processArray(array)
        }
        return nil
    }
    
    func processPair(_ ctx: MODLParser.Modl_pairContext) -> ModlPair? {
        var pair = ModlListenerObject.Pair()
        //Check key
        if let terminalString = ctx.STRING() {
            pair.key = getString(terminalString.getText())
        } else if let terminalQuote = ctx.QUOTED() {
            pair.key = getString(processQuotedString(terminalQuote.getText()))
        }
        
        //check value
        if let value = ctx.modl_map() {
            pair.value = processMap(value)
        } else if let value = ctx.modl_array() {
            pair.value = processArray(value)
        } else if let value = ctx.modl_value_item() {
            pair.value = processValueItem(value)
        }
        return pair
    }
    
    func processValueItem(_ ctx: MODLParser.Modl_value_itemContext) -> ModlValue? {
        if let value = ctx.modl_value() {
            if let nbArray = value.modl_nb_array() {
                return processNBArray(nbArray)
            }
            return processValue(value)
        } else if let conditional = ctx.modl_value_conditional() {
            return processValueConditional(conditional)
        }
        return nil
    }
    
    func processArray(_ ctx: MODLParser.Modl_arrayContext) ->ModlArray {
        guard let children = ctx.children else {
            //TODO: is this real? or should I return nil
            return ModlListenerObject.Array()
        }
        var arr = ModlListenerObject.Array()
        arr.values = processArrayChildren(children)
        return arr
    }
    
    func processArrayChildren(_ children: [ParseTree]) -> [ModlValue] {
        var output: [ModlValue] = []
        var previous: ParseTree? = nil
        for child in children {
            if let itemContext = child as? MODLParser.Modl_array_itemContext, let item = processArrayItem(itemContext) {
                output.append(item)
            } else if let itemContext = child as? MODLParser.Modl_nb_arrayContext, let item = processNBArray(itemContext) {
                output.append(item)
            } else if let uwPrev = previous as? TerminalNode, let uwChild = child as? TerminalNode {
                //We have two terminal nodes in a row, so output something UNLESS terminal symbols are new lines
                let prevSym = uwPrev.getSymbol()?.getType()
                let currSym = uwChild.getSymbol()?.getType()
                if prevSym == MODLLexer.LSBRAC && currSym == MODLLexer.RSBRAC {
                    //allows empty arrays
                    continue
                }
                if prevSym == MODLLexer.COLON && currSym == MODLLexer.COLON {
                    output.append(ModlListenerObject.Null())
                } else if prevSym == MODLLexer.STRUCT_SEP && currSym == MODLLexer.STRUCT_SEP {
                    output.append(ModlListenerObject.Null())
                }
            }
            previous = child
        }
        return output
    }
    
    func processArrayItem(_ ctx: MODLParser.Modl_array_itemContext) -> ModlValue? {
        if let conditional = ctx.modl_array_conditional() {
            return processArrayConditional(conditional)
        } else if let value = ctx.modl_array_value_item() {
            return processValue(value)
        }
        return nil
    }
    
    func processNBArray(_ ctx: MODLParser.Modl_nb_arrayContext) -> ModlValue? {
        guard let children = ctx.children else {
            //TODO: is this real? or should I return nil
            return ModlListenerObject.Array()
        }
        var arr = ModlListenerObject.Array()
        arr.values = processArrayChildren(children)
        return arr
    }
    
    func processMap(_ ctx: MODLParser.Modl_mapContext) -> ModlMap {
        var map = ModlListenerObject.Map()
        for item in ctx.modl_map_item() {
            if let item = processMapItemPair(item) {
                map.addValue(item)
            } else if let conditional = item.modl_map_conditional(), let processed = processMapConditional(conditional) {
                map.addConditional(processed)
            }
        }
        return map
    }
    
    func processMapItemPair(_ ctx: MODLParser.Modl_map_itemContext) -> ModlMapItem? {
        if let pair = ctx.modl_pair(), let mPair = processPair(pair), let mMapItem = ModlListenerObject.MapItem(pair: mPair) {
            return mMapItem
        }
        return nil
    }
    
    func processValue(_ ctx: MODLValueContext) -> ModlValue? {
        if let value = ctx.modl_array() {
            return processArray(value)
        } else if let value = ctx.modl_map() {
            return processMap(value)
        } else if let value = ctx.modl_pair() {
            return processPair(value)
        } else if let value = ctx.modl_primitive() {
            return processPrimitive(value)
        }
        return nil
    }
    
    //***********
    //MARK: - Terminals
    //***********
    func processPrimitive(_ ctx: MODLParser.Modl_primitiveContext) -> ModlValue? {
        if let value = ctx.STRING() {
            return getTerminalString(value)
        }  else if let value = ctx.QUOTED() {
            return getTerminalQuoted(value)
        } else if let value = ctx.NUMBER() {
            return getTerminalNumber(value)
        } else if ctx.NULL() != nil {
            return ModlListenerObject.Null()
        } else if let value = ctx.TRUE() {
            return getTerminalBool(value, value: true)
        } else if let value = ctx.FALSE() {
            return getTerminalBool(value, value: false)
        }
        return nil
    }
    
    func processQuotedString(_ quoted: String?) -> String? {
        guard var output = quoted else {
            return nil
        }
        if output.starts(with: "\"") && output.last == "\""{
            output.removeFirst()
            output.removeLast()
        }
        return output
    }
    
    func getTerminalString(_ ctx: TerminalNode?) -> ModlPrimitive {
        //TODO: escape
        var terminal = ModlListenerObject.Primitive()
        terminal.value = getString(ctx?.getText())
        return terminal
    }
    
    func getTerminalQuoted(_ ctx: TerminalNode?) -> ModlPrimitive {
        var terminal = ModlListenerObject.Primitive()
        terminal.value = getString(processQuotedString(ctx?.getText()))
        return terminal
    }

    func getTerminalBool(_ ctx: TerminalNode?, value: Bool) -> ModlPrimitive {
        var terminal = ModlListenerObject.Primitive()
        terminal.value = value
        return terminal
    }
    
    func getTerminalNumber(_ ctx: TerminalNode?) -> ModlPrimitive {
        var terminal = ModlListenerObject.Primitive()
        let numText = ctx?.getText() ?? ""
        terminal.value = Decimal(string: numText)  // Decimal(numText)
        return terminal
    }
    
    func getString(_ input: String?) -> String {
        guard let uwInput = input else {
            return ""
        }
        // do not remove graves
        return uwInput
    }

    //***********
    //MARK: - Conditionals
    //***********
    
    func processTopLevelConditional(_ ctx: MODLParser.Modl_top_level_conditionalContext) -> ModlListenerObject.TopLevelConditional? {
        var topLevelConditional = ModlListenerObject.TopLevelConditional()
        for (index, test) in ctx.modl_condition_test().enumerated() {
            if let condition = processConditionTest(test), let result = processTopLevelConditionalReturn(ctx.modl_top_level_conditional_return()[index]) {
                topLevelConditional.addTestAndReturn(testCase: condition, conditionalReturn: result)
            }
        }
        let returnCount = ctx.modl_top_level_conditional_return().count
        let testCount = ctx.modl_condition_test().count
        if  returnCount > testCount {
            //default return if no tests pass
            let endReturn = ctx.modl_top_level_conditional_return()[returnCount - 1]
            topLevelConditional.defaultReturn = processTopLevelConditionalReturn(endReturn)
        }
        return topLevelConditional
    }
    
    func processTopLevelConditionalReturn(_ ctx: MODLParser.Modl_top_level_conditional_returnContext) -> ModlListenerObject.TopLevelConditionalReturn? {
        var cReturn = ModlListenerObject.TopLevelConditionalReturn()
        for structure in ctx.modl_structure() {
            if let mStruct = processStructure(structure) {
                cReturn.addStructure(mStruct)
            }
        }
        return cReturn
    }
    
    func processMapConditional(_ ctx: MODLParser.Modl_map_conditionalContext) -> ModlListenerObject.MapConditional? {
        var mapConditional = ModlListenerObject.MapConditional()
        for (index, test) in ctx.modl_condition_test().enumerated() {
            if  let condition = processConditionTest(test),
                let result = processMapConditionalReturn(ctx.modl_map_conditional_return()[index]) {
                mapConditional.addTestAndReturn(testCase: condition, conditionalReturn: result)
            }
        }
        let returnCount = ctx.modl_map_conditional_return().count
        let testCount = ctx.modl_condition_test().count
        if  returnCount > testCount {
            //default return if no tests pass
            let endReturn = ctx.modl_map_conditional_return()[returnCount - 1]
            mapConditional.defaultReturn = processMapConditionalReturn(endReturn)
        }
        return mapConditional
    }
    
    func processMapConditionalReturn(_ ctx: MODLParser.Modl_map_conditional_returnContext) -> ModlListenerObject.MapConditionalReturn? {
        var cReturn = ModlListenerObject.MapConditionalReturn()
        for structure in ctx.modl_map_item() {
            if let mStruct = processMapItemPair(structure) {
                cReturn.addItem(mStruct)
            }
        }
        return cReturn
    }
    
    func processArrayConditional(_ ctx: MODLParser.Modl_array_conditionalContext) -> ModlListenerObject.ArrayConditional? {
        var arrayConditional = ModlListenerObject.ArrayConditional()
        for (index, test) in ctx.modl_condition_test().enumerated() {
            if  let condition = processConditionTest(test),
                let result = processArrayConditionalReturn(ctx.modl_array_conditional_return()[index]) {
                arrayConditional.addTestAndReturn(testCase: condition, conditionalReturn: result)
            }
        }
        let returnCount = ctx.modl_array_conditional_return().count
        let testCount = ctx.modl_condition_test().count
        if  returnCount > testCount {
            //default return if no tests pass
            let endReturn = ctx.modl_array_conditional_return()[returnCount - 1]
            arrayConditional.defaultReturn = processArrayConditionalReturn(endReturn)
        }
        return arrayConditional
    }
    
    func processArrayConditionalReturn(_ ctx: MODLParser.Modl_array_conditional_returnContext) -> ModlListenerObject.ArrayConditionalReturn? {
        var cReturn = ModlListenerObject.ArrayConditionalReturn()
        for structure in ctx.modl_array_item() {
            if let mStruct = processArrayItem(structure) {
                cReturn.addItem(mStruct)
            }
        }
        return cReturn
    }
    
    func processValueConditional(_ ctx: MODLParser.Modl_value_conditionalContext) -> ModlListenerObject.ValueConditional? {
        var valueConditional = ModlListenerObject.ValueConditional()
        for (index, test) in ctx.modl_condition_test().enumerated() {
            if let condition = processConditionTest(test) {
                if ctx.modl_value_conditional_return().count > 0,
                    let result = processValueConditionalReturn(ctx.modl_value_conditional_return()[index]) {
                        valueConditional.addTestAndReturn(testCase: condition, conditionalReturn: result)
                } else {
                    valueConditional.addTestAndReturn(testCase: condition, conditionalReturn: nil)
                }
            }
        }
        let returnCount = ctx.modl_value_conditional_return().count
        let testCount = ctx.modl_condition_test().count
        if  returnCount > testCount {
            //default return if no tests pass
            let endReturn = ctx.modl_value_conditional_return()[returnCount - 1]
            valueConditional.defaultReturn = processValueConditionalReturn(endReturn)
        }
        return valueConditional
    }
    
    func processValueConditionalReturn(_ ctx: MODLParser.Modl_value_conditional_returnContext) -> ModlListenerObject.ValueConditionalReturn? {
        var cReturn = ModlListenerObject.ValueConditionalReturn()
        for structure in ctx.modl_value_item() {
            if let mStruct = processValueItem(structure) {
                cReturn.addItem(mStruct)
            }
        }
        return cReturn
    }

    
    //***********
    //MARK: Conditions
    //***********
    func processConditionTest(_ ctx: MODLParser.Modl_condition_testContext) -> ModlListenerObject.ConditionTest? {
        var test = ModlListenerObject.ConditionTest()
        var shouldNegate = false
        var lastOperator: String? = nil
        for child in ctx.children  ?? [] {
            if let group = child as? MODLParser.Modl_condition_groupContext, let cGroup = processConditionGroup(group, shouldNegate: shouldNegate, lastOperator: lastOperator) {
                test.subConditionList.append(cGroup)
                lastOperator = nil
                shouldNegate = false
            } else if let condition = child as? MODLParser.Modl_conditionContext, let con = processCondition(condition, shouldNegate: shouldNegate, lastOperator: lastOperator) {
                test.subConditionList.append(con)
                lastOperator = nil
                shouldNegate = false
            } else {
                if child.getText() == "!" {
                    shouldNegate = true
                } else {
                    lastOperator = child.getText()
                }
            }
        }
        return test
    }
    
    func processConditionGroup(_ ctx: MODLParser.Modl_condition_groupContext, shouldNegate: Bool = false, lastOperator: String?) -> ModlListenerObject.ConditionGroup? {
        var testList: [ModlListenerObject.ConditionTest] = []
        var lastSubOp: String? = nil
        for child in ctx.children ?? [] {
            if let testCtx = child as? MODLParser.Modl_condition_testContext, var conTest = processConditionTest(testCtx) {
                conTest.lastOperator = lastSubOp
                testList.append(conTest)
                lastSubOp = nil
            } else {
                if child.getText() != "{" && child.getText() != "}" {
                    lastSubOp = child.getText()
                }
            }
        }
        let conditionGroup = ModlListenerObject.ConditionGroup(shouldNegate: shouldNegate, lastOperator: lastOperator, conditionTests: testList)
        return conditionGroup
    }
    
    func processCondition(_ ctx: MODLParser.Modl_conditionContext, shouldNegate: Bool = false, lastOperator: String?) -> ModlListenerObject.Condition? {
        var condition = ModlListenerObject.Condition(key: nil, operatorType: nil, values: nil, shouldNegate: shouldNegate, lastOperator: lastOperator)
        condition.key = ctx.STRING()?.getText()
        condition.operatorType = ctx.modl_operator()?.getText()
        condition.values = ctx.modl_value().compactMap({ (ctx) -> ModlValue? in
            return processValue(ctx)
        })
        return condition
    }
    
}

protocol MODLValueContext {
    func modl_map() -> MODLParser.Modl_mapContext?
    func modl_array() -> MODLParser.Modl_arrayContext?
    func modl_pair() -> MODLParser.Modl_pairContext?
    func modl_primitive() -> MODLParser.Modl_primitiveContext?
}

extension MODLParser.Modl_array_value_itemContext: MODLValueContext {
}

extension MODLParser.Modl_valueContext: MODLValueContext {
}
