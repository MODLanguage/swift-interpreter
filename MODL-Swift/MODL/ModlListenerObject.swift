//
//  ModlListenerObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

class ModlListenerObject: ModlObject {
    var structures: [ModlStructure] = []
    
    struct Pair: ModlPair {
        var key: String?
        var value: ModlValue?
    }
    
    struct Array: ModlArray {
        mutating func addValue(_ value: ModlValue) {
            self.values.append(value)
        }
        
        var values: [ModlValue] = []
    }
    
    struct Map: ModlMap {
        var values: [String : ModlValue] = [:]
        var orderedKeys: [String] = []
    }
    
    struct Null: ModlNull {
    }
    
    struct Primitive: ModlPrimitive {
        mutating func setValue(value: Any?) {
            self.value = value
        }
        
        var value: Any?
    }
}
