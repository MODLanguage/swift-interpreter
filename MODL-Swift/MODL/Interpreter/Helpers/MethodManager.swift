//
//  MethodManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 07/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

fileprivate enum MethodSpecialKeys: String, CaseIterable {
    case identifier = "*id"
    case identifierSH = "*i"
    case name = "*name"
    case nameSH = "*n"
    case transform = "*transform"
    case transformSH = "*t"
}

struct MethodManager {
    private var storedMethods: [String: Method] = [:]
    private var methodOrder: [String] = []

    func addMethod(_ method: ModlValue?) {
        
    }
}

fileprivate struct Method {
    let id: String
    let name: String
    let transform: String?
    
    init?(_ map: ModlValue?) {
        guard let methodMap = map as? ModlMap else {
            return nil
        }
        if let methodId = (methodMap.value(forKeys: ["*i", "*id"], ignoreCase: true) as? ModlPrimitive)?.asString() {
            id = methodId
            name = (methodMap.value(forKeys: ["*n", "*name"], ignoreCase: true) as? ModlPrimitive)?.asString() ?? methodId
            transform = (methodMap.value(forKeys: ["*t", "*transform"], ignoreCase: true) as? ModlPrimitive)?.asString()
        } else {
            return nil
        }
    }

}
