//
//  StringEscapeReplacer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 14/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct StringEscapeReplacer {
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
        
        "~`" : "`",
        "\\`" : "`",
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
    
    func replace(_ inputString: String) -> String {
        var output = inputString
        for (key, value) in StringEscapeReplacer.replacements {
            output = output.replacingOccurrences(of: key, with: value)
        }
        return output
    }
}
