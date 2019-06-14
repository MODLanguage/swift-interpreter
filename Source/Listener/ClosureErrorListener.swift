//
//  ThrowingErrorListener.swift
//  MODL-Interpreter
//
//  Created by Nicholas Jones on 14/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
import Antlr4

class ClosureErrorListener: BaseErrorListener {
    
    var errorHandler: ((_ line: Int, _ char: Int,  _ msg: String) -> ())?
    
    override func syntaxError<T>(_ recognizer: Recognizer<T>, _ offendingSymbol: AnyObject?, _ line: Int, _ charPositionInLine: Int, _ msg: String, _ e: AnyObject?) where T : ATNSimulator  {
        errorHandler?(line, charPositionInLine, msg)
    }
}
