//
//  ModlParser.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
import Antlr4

struct ModlParser {
    func parse(_ input: String) -> String? {
        let lexer = MODLLexer(ANTLRInputStream(input))
        do {
            let parser = try MODLParser(CommonTokenStream(lexer))
            //            parser.removeErrorListeners()
            let base = ModlListener()
            try parser.modl().enterRule(base)
            let object = base.object
            var jsonData: Data? = nil
            if object.structures.count > 1 {
                jsonData = try JSONEncoder().encode(object.structures)
            } else {
                jsonData = try JSONEncoder().encode(object.structures.first)
            }
            if let data = jsonData {
                return String(data: data, encoding: .utf8)
            }
            return nil
        } catch {
            print("Parser fail : \(error)")
            return nil
        }
    }
}
