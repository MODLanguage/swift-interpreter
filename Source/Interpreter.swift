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
    
    case parserError
    
    case invalidVersion
    case mismatchedVersion
    case versionNotFirst

    case invalidKey
    case immutableKey
    
    case invalidObjectReference
    case invalidKeyword

    case methodAlreadyDefined
    case invalidMethod
    
    case invalidClass
    case classAssignOrder
    case classNoMatchingAssign
    case classAlreadyDefined
    case immutableClass
    case invalidSuperclass
    case mismatchedSuperclass
    case reservedClassId
    
    case missingFile
    case immutableLoad
}


extension InterpreterError: LocalizedError {
    public var errorDescription: String? {
        let header = "Interpreter Error:"
        switch self {
        case .mismatchedVersion:
            return "Interpreter Warning: version number does not match current MODL version"
        case .invalidVersion:
            return "\(header)  Invalid MODL version"
        case .versionNotFirst:
            return "\(header)  MODL version should be on the first line if specified."
            
        case .invalidKey:
            return "\(header)  Invalid key"
        case .immutableKey:
            return "\(header)  Already defined key as immutable"
        case .invalidObjectReference:
            return "\(header)  Cannot resolve reference"
        case .methodAlreadyDefined:
            return "\(header)  Duplicate method id or name"
        case .classAlreadyDefined:
            return "\(header)  Class name or id already defined - cannot redefine"
        case .classAssignOrder:
            return "\(header)  Key lists in *assign are not in ascending order of list length"
        case .classNoMatchingAssign:
            return "\(header)  No key list of the correct length in class"
        case .invalidClass:
            return "\(header)  Invalid class definition"
        case .invalidSuperclass:
            return "\(header)  Invalid superclass"
        case .invalidMethod:
            return "\(header)  Invalid method definition"
        case .missingFile:
            return "\(header) File not found"
        case .immutableLoad:
            return "\(header) Cannot load multiple files after *LOAD instruction"
        case .immutableClass:
            return "\(header) Already defined *class as final"
        case .mismatchedSuperclass:
            return "\(header) Superclass type does not match value"
        case .parserError:
            return "\(header) Cannot parse file"
        case .reservedClassId:
            return "\(header) Reserved class id - cannot redefine"
        case .invalidKeyword:
            return "\(header) Invalid keyword"
//        default:
//            return "\(header) Unknown error"
        }
    }
}

public class Interpreter {
    //keep reference to this so cache stays whilst interpreter exists
    private let fileLoader = FileLoader()
    private var parserError: Error? = nil
    
    public init() {}
    
    public func parseToJson(_ input: String) throws -> String {
        let intermediate = try parseToModlObject(input)
        let outputGenerator = ModlObjectCreator(fileLoader)
        let output = try outputGenerator.createOutput(intermediate)
        for warning in outputGenerator.warnings {
            print("Interpreter Warning: \(warning.localizedDescription)")
        }
        return output?.asJson() ?? ""
    }
    
    public func parseToModlObject(_ input: String) throws -> ModlListenerObject? {
        let lexer = MODLLexer(ANTLRInputStream(input))
        let parser = try MODLParser(CommonTokenStream(lexer))
        parser.removeErrorListeners()
        let errorListener = ClosureErrorListener()
        errorListener.errorHandler = { (line, char, msg) in
            self.parserError = InterpreterError.parserError
        }
        parser.addErrorListener(errorListener)
        let base = ModlListener()
        try parser.modl().enterRule(base)
        if let error = base.parseError {
            throw error
        } else if let error = parserError {
            throw error
        }
        return base.object
    }
}
