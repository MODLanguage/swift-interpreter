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
//  StringEscapeReplacer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 14/05/2019.

import Foundation

internal struct StringEscapeReplacer {
    private static let replacements: [String: String] = [
        "~\\" : "\\",
        "\\\\" : "\\",
        "~~" : "~",
        "\\~" : "~",
        "~(" : "(",
        "\\(" : "(",
        "~)" : ")",
        "\\)" : ")",
        
        "~[" : "[",
        "\\[" : "[",
        "~]" : "]",
        "\\]" : "]",
        
        "~{" : "{",
        "\\{" : "{",
        "~}" : "}",
        "\\}" : "}",
        
        "~;" : ";",
        "\\;" : ";",
        "~:" : ":",
        "\\:" : ":",
        
        "~\"" : "\"",
        "\\\"" : "\"",
        
        "~=" : "=",
        "\\=" : "=",
        "~/" : "/",
        "\\/" : "/",
        
        "<" : "<",
        "\\<" : "<",
        "~>" : ">",
        "\\>" : ">",
        
        "~&" : "&",
        "\\&" : "&",
        
        "!" : "!",
        "\\!" : "!",
        "~|" : "|",
        "\\|" : "|",
        
        //TODO: check these and all other replacements make sense with Swift strings
        //        "\\t" : "\t",
//        "\\n" : "\n",
//        "\\b" : "\b",
//        "\\f" : "\f",
//        "\\r" : "\r"
    ]
    
    private static let graveReplacements = [
                "~`" : "`",
                "\\`" : "`"
    ]
    
    func replace(_ inputString: String) -> String {
        var output = inputString
        for (key, value) in StringEscapeReplacer.replacements {
                output = output.replacingOccurrences(of: key, with: value)
        }
        return output
    }
    
    func replaceGraves(_ inputString: String) -> String
    {
        var output = inputString
        for (key, value) in StringEscapeReplacer.graveReplacements {
            output = output.replacingOccurrences(of: key, with: value)
        }
        return output
    }
}
