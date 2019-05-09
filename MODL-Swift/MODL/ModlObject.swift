//
//  ModlObject.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation


class ModlObject: Encodable {
    
    class ModlValue: Codable {
    }
    
    class ModlStructure: ModlValue {
    }

    //MARK: - Structures
    //MARK: Pair
    class ModlPair: ModlStructure {
        var key: String? = nil
        var value: ModlValue? = nil
        
        var dict: [String: ModlValue] {
            guard let uwKey = key, let uwV = value else {
                return [:]
            }
            return [uwKey: uwV]
        }
        
        convenience init(key: String?, value: ModlValue?) {
            self.init()
            self.key = key
            self.value = value
        }

        private struct CodingKeys: CodingKey {
            var intValue: Int?
            var stringValue: String
            
            init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
            init?(stringValue: String) { self.stringValue = stringValue }
            
            static let name = CodingKeys.make(key: "categoryName")
            static func make(key: String) -> CodingKeys {
                return CodingKeys(stringValue: key)!
            }
        }
        
        override func encode(to encoder: Encoder) throws {
            guard let uwKey = key, let uwV = value else {
                return
            }
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(uwV, forKey: .make(key: uwKey))
        }
    }
    
    //MARK: Array
    class ModlArray: ModlStructure {
        var values: [ModlValue] = []
        
        override func encode(to encoder: Encoder) throws {
            var container = encoder.unkeyedContainer()
            try container.encode(contentsOf: values)
        }
    }
    
    //MARK: Map
    class ModlMap: ModlStructure {
        private var values: [String: ModlValue] = [:]
        private var orderedKeys: [String] = []
        
        func addValue(key: String, value: ModlValue) {
            print("Map key added: \(key)")
            values[key] = value
            orderedKeys.append(key)
        }
        
        private struct CodingKeys: CodingKey {
            var intValue: Int?
            var stringValue: String
            
            init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
            init?(stringValue: String) { self.stringValue = stringValue }
            
            static let name = CodingKeys.make(key: "categoryName")
            static func make(key: String) -> CodingKeys {
                return CodingKeys(stringValue: key)!
            }
        }
        
        override func encode(to encoder: Encoder) throws {
            print("Encode map ordered: \(orderedKeys)")
            var container = encoder.container(keyedBy: CodingKeys.self)
            for key in orderedKeys {
                if let uwValue = values[key]{
                    try container.encode(uwValue, forKey: .make(key: key))
                }
            }
            
        }
//        override func encode(to encoder: Encoder) throws {
//            var container = encoder.unkeyedContainer()
//
//
////            if values.count == 1, let first = values.first {
////                try container.encode(first)
////            } else {
//            try container.encode(values)
////            }
//        }
    }
    
    class ModlNull: ModlStructure {
        //TODO: check null works as null (not omitted)
        let nullValue: String? = nil

        override func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
    
    class ModlTerminal: ModlValue {
        var terminalValue: Any? = nil
        
        override func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            if let uwString = terminalValue as? String {
                try container.encode(uwString)
            } else if let uwBool = terminalValue as? Bool {
                try container.encode(uwBool)
            } else if let uwNumber = terminalValue as? Decimal {
                try container.encode(uwNumber)
            } else if let uwNumber = terminalValue as? Float {
                try container.encode(uwNumber)
            } else if let uwNumber = terminalValue as? Int64 {
                try container.encode(uwNumber)
            }
        }
    }

    
    var structures: [ModlStructure] = []
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(contentsOf: structures)
    }
    
    func addStructure(_ structure: ModlStructure) {
        structures.append(structure)
    }
}
