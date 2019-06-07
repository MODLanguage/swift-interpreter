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
//  ModlObjectReferenceManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 15/05/2019.
//

import Foundation

class ModlObjectReferenceManager {
    private var numberedVariables: [ModlValue?] = []
    private var keyedVariables: [String: ModlValue] = [:]
    
    func addIndexedVariables(_ mValue: ModlValue?) {
        guard let uwMValue = mValue else {
            return
        }
        if let array = uwMValue as? ModlArray {
            for (index, value) in array.values.enumerated() {
                numberedVariables.insert(value, at: index)
            }
        } else {
            numberedVariables[0] = uwMValue
        }
    }
    
    func addKeyedVariable(key: String?, value: ModlValue?) {
        guard var uwKey = key, let uwValue = value else {
            return
        }
        if uwKey.hasPrefix("_") {
            uwKey.removeFirst()
        }
        keyedVariables[uwKey] = uwValue
    }
    
    func getKeyedVariable(_ key: String?) -> ModlValue? {
        guard var uwKey = key else {
            return nil
        }
        if uwKey.hasPrefix("_") {
            uwKey.removeFirst()
        }
        return keyedVariables[uwKey]
    }
    
    func getIndexedVariable(_ index: Int) -> ModlValue? {
        guard index < numberedVariables.count else {
            return nil
        }
        return numberedVariables[index]
    }
}
