//
//  MODLTest.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 07/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
struct MODLTest: Codable {
    let modl: String
    let minModl: String
    let expectedJson: String
    let comment: String?
    
    enum CodingKeys: String, CodingKey {
        case comment
        case modl = "input"
        case minModl = "minimised_modl"
        case expectedJson = "expected_output"
    }
}
