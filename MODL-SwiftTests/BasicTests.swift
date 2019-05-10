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
        jsonTests = MODLTest.getAllTests(self)
    }
    
    
    func testAllJSONExamples() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let basic = json.filter { (modl) -> Bool in
            modl.isBasicTest()
        }
        for test in basic {
            print("******TEST START********\n************")
            print("Test: \(test.modl)")
            let p = ModlParser()
            do {
                let result = try p.parse(test.modl)
                let expected = test.expectedJson
                if expected.count == 0 {
                    //empty test
                    XCTAssert(result == expected, "\nExpected: \(expected)\nGot: \(result)")
                } else {
                    XCTAssert(result == test.expectedJson, "\nExpected: \(test.expectedJson)\nGot: \(result)")
                }
            } catch {
                XCTFail("Error caught \(error.localizedDescription)")
            }
            print("******TEST END********\n************")
        }
        print("TOTAL TESTS: \(basic.count)")
    }

}
