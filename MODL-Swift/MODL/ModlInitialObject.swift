//
//  ModlObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

class ModlInitialObject: ModlObject {
    var structures: [ModlStructure] = []
    
    class Pair: ModlPair {
        var key: String?
        var value: ModlValue?
    }
    
    class Array: ModlArray {
        var values: [ModlValue] = []
    }
    
    class Map: ModlMap {
        var values: [String : ModlValue] = [:]
        var orderedKeys: [String] = []
    }
    
    class Null: ModlNull {
    }
    
    class Primitive: ModlPrimitive {
        var value: Any?
    }
}
