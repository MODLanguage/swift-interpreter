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
    var object: ModlObject = ModlObject()
    
    override func enterModl(_ ctx: MODLParser.ModlContext) {
        for mStructure in ctx.modl_structure() {
            if let structure = processStructure(mStructure) {
                object.addStructure(structure)
            }
        }
        print("MODL: \(object)")
    }
    
    func processStructure(_ ctx: MODLParser.Modl_structureContext) -> ModlObject.ModlStructure? {
        if let pair = ctx.modl_pair() {
            return processPair(pair)
        } else if let conditional = ctx.modl_top_level_conditional() {
            print("is conditional")
        } else if let map = ctx.modl_map() {
            return processMap(map)
        } else if let array = ctx.modl_array() {
            return processArray(array)
        }
        return nil
    }
    
    func processPair(_ ctx: MODLParser.Modl_pairContext) -> ModlObject.ModlPair {
        print("Processing: Pair")
        let pair = ModlObject.ModlPair()
        //Check key
        if let terminalString = ctx.STRING() {
            pair.key = getString(terminalString.getText())
        } else if let terminalQuote = ctx.QUOTED() {
            var quoted = getString(terminalQuote.getText())
            if quoted.count > 0 {
                quoted.removeFirst()
                quoted.removeLast()
            }
            pair.key = quoted
        }
        
        //check value
        if let value = ctx.modl_map() {
            pair.value = processMap(value)
        } else if let value = ctx.modl_array() {
            pair.value = processArray(value)
        } else if let value = ctx.modl_value_item() {
            pair.value = processValueItem(value)
        }
        //TODO: handling the rest for the conversion i.e. methods and classes
        return pair
    }
    
    func processValueItem(_ ctx: MODLParser.Modl_value_itemContext) -> ModlObject.ModlValue? {
        if let value = ctx.modl_value() {
            if let nbArray = value.modl_nb_array() {
                //TODO: do this instead
                return nil
            }
            return processValue(value)
        } else if let condtional = ctx.modl_value_conditional() {
            //TODO: process conditional
        }
        return nil
    }
    
    func processArray(_ ctx: MODLParser.Modl_arrayContext) -> ModlObject.ModlArray {
        print("Processing: Array")
        guard let children = ctx.children else {
            //TODO: is this real? or should I return nil
            return ModlObject.ModlArray()
        }
        var arr = ModlObject.ModlArray()
        for child in children {
            if child.getChildCount() == 0 {
                //TODO:
                continue
            } else if let item = child as? MODLParser.Modl_array_itemContext {
                if let arrayItem = processArrayItem(item) {
                    arr.values.append(arrayItem)
                }
            } else if let item = child as? MODLParser.Modl_nb_arrayContext {
                //TODO: handle nb array
            }
        }
        return arr
    }
    
    func processMap(_ ctx: MODLParser.Modl_mapContext) -> ModlObject.ModlMap {
        print("Processing: Map")
        var map = ModlObject.ModlMap()
        return map
    }
    
    func processArrayItem(_ ctx: MODLParser.Modl_array_itemContext) -> ModlObject.ModlValue? {
        if let conditional = ctx.modl_array_conditional() {
            //FIXME: process conditional
            return nil
        } else if let value = ctx.modl_array_value_item() {
            //TODO: Should this be a array specific method? or can I piggyback of existing value parser
            return processValue(value)
        }
        return nil
    }
    
    func processValue(_ ctx: MODLValueContext) -> ModlObject.ModlValue? {
        if let value = ctx.modl_array() {
            return processArray(value)
        } else if let value = ctx.modl_pair() {
            return processPair(value)
        } else if let value = ctx.STRING() {
            return getTerminalString(value)
        }  else if let value = ctx.QUOTED() {
            return getTerminalString(value)
        } else if let value = ctx.NUMBER() {
            return getTerminalNumber(value)
        } else if ctx.NULL() != nil {
            return ModlObject.ModlNull()
        } else if let value = ctx.TRUE() {
            return getTerminalBool(value, value: true)
        } else if let value = ctx.FALSE() {
            return getTerminalBool(value, value: false)
        }
        //TODO: process the rest of the terminal types
        return nil
    }
    
    func getTerminalString(_ ctx: TerminalNode?) -> ModlObject.ModlTerminal {
        //TODO: escape
        let terminal = ModlObject.ModlTerminal()
        terminal.terminalValue = getString(ctx?.getText())
        return terminal
    }
    
    func getTerminalBool(_ ctx: TerminalNode?, value: Bool) -> ModlObject.ModlTerminal {
        let terminal = ModlObject.ModlTerminal()
        terminal.terminalValue = value
        return terminal
    }
    
    func getTerminalNumber(_ ctx: TerminalNode?) -> ModlObject.ModlTerminal {
        let terminal = ModlObject.ModlTerminal()
        terminal.terminalValue = Double(ctx?.getText() ?? "")
        return terminal
    }
    
    func getString(_ input: String?) -> String {
        //TODO: escape
        return input ?? ""
    }
    
}

protocol MODLValueContext {
    func modl_map() -> MODLParser.Modl_mapContext?
    func modl_array() -> MODLParser.Modl_arrayContext?
    func modl_pair() -> MODLParser.Modl_pairContext?
    func QUOTED() -> TerminalNode?
    func NUMBER() -> TerminalNode?
    func STRING() -> TerminalNode?
    func TRUE() -> TerminalNode?
    func FALSE() -> TerminalNode?
    func NULL() -> TerminalNode?
}

extension MODLParser.Modl_valueContext: MODLValueContext {
}

extension MODLParser.Modl_array_value_itemContext: MODLValueContext {
}
