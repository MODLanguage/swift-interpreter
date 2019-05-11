//
//  ModlObjectProtocols.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 10/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

protocol ModlObject: AnyObject {
    var structures: [ModlStructure] {get set}
}

extension ModlObject {
    func addStructure(_ structure: ModlStructure) {
        self.structures.append(structure)
    }
}
protocol ModlValue: AnyObject {}
protocol ModlStructure: ModlValue {}
protocol ModlPair: ModlStructure {
    var key: String? {get set}
    var value: ModlValue? {get set}
}

protocol ModlArray: ModlStructure {
    var values: [ModlValue] {get set}
}

protocol ModlMap: ModlStructure {
    var values: [String: ModlValue] {get set}
    var orderedKeys: [String] {get set}
}

protocol ModlPrimitive: ModlValue {
    var value: Any? {get set}
}

extension ModlPrimitive {
    func asString() -> String? {
        switch value {
        case let int as Int:
            return String(int)
        case let dec as Decimal:
            return "\(dec)"
        case let str as String:
            return str
        default:
            return nil
        }
    }
}

protocol ModlNull: ModlValue {}

extension ModlMap {
    func addValue(key: String, value: ModlValue) {
        print("Map key added: \(key)")
        values[key] = value
        orderedKeys.append(key)
    }
    
    func value(forKey key: String, ignoreCase: Bool = false) -> ModlValue? {
        if ignoreCase {
            for (vKey,value) in values {
                if vKey.lowercased() == key.lowercased() {
                    return value
                }
            }
            return nil
        } else {
            return values[key]
        }
    }
    
    func value(forKeys keys: [String], ignoreCase: Bool = false) -> ModlValue? {
        for key in keys {
            if let value = value(forKey: key, ignoreCase: ignoreCase) {
                return value
            }
        }
        return nil
    }
}
