//
//  ModlClassManager.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 09/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

class ModlClassManager {
    fileprivate var storedClasses: [String: ModlClass] = [:]
    
    func processClass(_ classMap: ModlValue?) {
        guard let input = classMap as? ModlMap, var mClass = ModlClass(input) else {
            //either not a map, or has no id so ignore ...
            //TODO: raise bad class error?
            return
        }
        if let superclassName = mClass.superclass {
            if superclassName.uppercased() == superclassName {
                //TODO: error for non-mutable class
                //TODO: check does this make sense? Why would uppercase name be an immutable issue here?
                return
            }
           //has a superclass mentioned so check for it....
            if let existingingSuperClass = storedClasses[superclassName] {
                mClass.name = existingingSuperClass.name
                //TODO: this should probably loop through and update individual bits rather than overwrite
                mClass.assignMap = existingingSuperClass.assignMap
                mClass.extraValues = existingingSuperClass.assignMap
            }
        }
        storedClasses[mClass.id] = mClass
     }
}


fileprivate struct ModlClass {
    let id: String
    var superclass: String? = nil
    var name: String
    var assignMap: Any?
    var extraValues: Any?
    
    init?(_ map: ModlValue?) {
        guard let classMap = map as? ModlMap else {
            return nil
        }
        if let mClassId = classMap.value(forKeys: ["*i", "*id"], ignoreCase: true) as? ModlPrimitive, let classId = mClassId.asString() {
            id = classId
            superclass = (classMap.value(forKeys: ["*s", "*superclass"], ignoreCase: true) as? ModlPrimitive)?.asString()
            name = (classMap.value(forKeys: ["*n", "*name"], ignoreCase: true) as? ModlPrimitive)?.asString() ?? classId
            assignMap = classMap.value(forKeys: ["*a", "*assign"], ignoreCase: true)
            extraValues = nil
        } else {
            return nil
        }
    }
    
}

