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
//  ModlParser.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import Foundation
import Antlr4

public enum InterpreterError: Error {
    case invalidVersion
    case mismatchedVersion
    case invalidClass
    case missingFile
}

public struct Interpreter {
    //keep reference to this so cache stays whilst interpreter exists
    private let fileLoader = FileLoader()
    public init() {}
    
    public func parseToJson(_ input: String) throws -> String {
        let intermediate = try parseToRawModl(input)
        let outputGenerator = ModlObjectCreator(fileLoader)
        let output = try outputGenerator.createOutput(intermediate)
        return output?.asJson() ?? ""
    }
    
    internal func parseToRawModl(_ input: String) throws -> ModlListenerObject? {
        let lexer = MODLLexer(ANTLRInputStream(input))
        let parser = try MODLParser(CommonTokenStream(lexer))
        //            parser.removeErrorListeners()
        let base = ModlListener()
        try parser.modl().enterRule(base)
        if let error = base.parseError {
            throw error
        }
        return base.object
    }
}
