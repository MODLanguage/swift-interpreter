//
//  ModlObjectReferenceManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 15/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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
    
    func addKeyedVariable(_ pair: ModlPair?) {
        guard let uwPair = pair, var key = uwPair.key, let value = uwPair.value else {
            return
        }
        if key.hasPrefix("_") {
            key.removeFirst()
        }
        keyedVariables[key] = value
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
