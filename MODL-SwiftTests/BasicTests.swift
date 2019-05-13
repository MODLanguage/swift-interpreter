//
//  BasicTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 07/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest

class BasicTests: XCTestCase {

    var jsonTests: [MODLTest]?
    
    override func setUp() {
        jsonTests = MODLTestManager.getAllTests(self)
    }
    
    override func tearDown() {
        jsonTests = nil
    }
    
    func testAllBasicExamples() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let basic = json.filter { (modl) -> Bool in
            modl.isBasicTest()
        }
        MODLTestManager.performTests(basic)
    }
}
