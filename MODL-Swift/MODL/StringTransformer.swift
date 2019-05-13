//
//  StringTransformer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 13/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct StringTransformer {
    func transformString(_ inputString: String?) -> ModlValue? {
        let prim = ModlOutputObject.Primitive()
        prim.value = inputString
        return prim
    }
}
