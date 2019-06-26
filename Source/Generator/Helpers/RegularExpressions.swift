//
//  RegularExpressions.swift
//  MODL-Interpreter
//
//  Created by Nicholas Jones on 26/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct RegularExpressions {
    static let methodSubjectPattern = #"%((?<![\\~])`)[^`].+((?<![\\~])`)"#
    static let subjectMethodInclusivePattern = #"\#(RegularExpressions.methodSubjectPattern)(\.[a-zA-Z0-9_%]+\#(RegularExpressions.methodPattern))*"#
    private static let methodPattern = #"(<[a-zA-Z,`]*>)*"#
    static let objectReferencePattern = #"%[^`.]?(([0-9]+)|[a-zA-Z_]+[a-zA-Z0-9_]*)(\.%?[a-zA-Z0-9_]+\#(RegularExpressions.methodPattern))*%?"#
}
