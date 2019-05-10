//
//  ModlParser.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
import Antlr4

enum ModlParserError: Error {
    case invalidVersion
    case invalidClass
}

struct ModlParser {
    func parse(_ input: String) throws -> String {
        let lexer = MODLLexer(ANTLRInputStream(input))
        do {
            let parser = try MODLParser(CommonTokenStream(lexer))
//            parser.removeErrorListeners()
            let base = ModlListener()
            try parser.modl().enterRule(base)
            if let error = base.parseError {
                throw error
            }
            let initialObject = base.object
            let converter = ModlObjectCreator()
            let output = converter.createOutput(initialObject)
            return output?.asJson() ?? ""
//            var jsonData: Data? = nil
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .sortedKeys
//            if object.structures.count > 1 {
//                jsonData = try encoder.encode(object.structures)
//            } else if let first = object.structures.first {
//                jsonData = try encoder.encode(first)
//            } else {
//                return ""
//            }
//            if let data = jsonData {
//                return String(data: data, encoding: .utf8) ?? ""
//            }
            return ""
        } catch {
            print("Parser fail : \(error)")
            return ""
        }
    }
}
