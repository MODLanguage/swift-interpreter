//
//  ModlListener.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
import Antlr4


class ModlListener: MODLParserBaseListener {
    
    static let ModlVersion = 1.0 // included version of MODL grammer
    
    var object = ModlListenerObject()
    var parseError: Error?
    
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
//            print("is conditional")
        } else if let map = ctx.modl_map() {
            return processMap(map)
        } else if let array = ctx.modl_array() {
            return processArray(array)
        }
        return nil
    }
    
    func processPair(_ ctx: MODLParser.Modl_pairContext) -> ModlPair? {
//        print("Processing: Pair")
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
            //TODO: process conditional
        }
        return nil
    }
    
    func processArray(_ ctx: MODLParser.Modl_arrayContext) ->ModlArray {
//        print("Processing: Array")
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
            //FIXME: process conditional
            return nil
        } else if let value = ctx.modl_array_value_item() {
            //TODO: Should this be a array specific method? or can I piggyback of existing value parser
            return processValue(value)
        }
        return nil
    }
    
    func processNBArray(_ ctx: MODLParser.Modl_nb_arrayContext) -> ModlValue? {
//        print("processing: NB array")
        guard let children = ctx.children else {
            //TODO: is this real? or should I return nil
            return ModlListenerObject.Array()
        }
        var arr = ModlListenerObject.Array()
        arr.values = processArrayChildren(children)
        return arr
    }
    
    func processMap(_ ctx: MODLParser.Modl_mapContext) -> ModlMap {
//        print("Processing: Map")
        var map = ModlListenerObject.Map()
        for item in ctx.modl_map_item() {
            if let pair = processMapItemPair(item), let key = pair.key, let value = pair.value {
                map.addValue(key: key, value: value)
            } else {
                //TODO: process conditional
            }
        }
        return map
    }
    
    func processMapItemPair(_ ctx: MODLParser.Modl_map_itemContext) -> ModlPair? {
        if let pair = ctx.modl_pair() {
            return processPair(pair)
        }
        return nil
    }
    
    func processMapItemConditional(_ ctx: MODLParser.Modl_map_itemContext) ->ModlPair? {
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
        return uwInput //.replacingOccurrences(of: "`", with: "")
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
