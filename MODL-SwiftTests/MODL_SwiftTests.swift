//
//  MODL_SwiftTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest
@testable import MODL_Swift

class MODL_SwiftTests: XCTestCase {

    var jsonTests: [MODLTest]?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "base_tests", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            jsonTests = try JSONDecoder().decode([MODLTest].self, from: data)
        } catch {
            XCTFail("Fail creating tests from json input")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllJSONExamples() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        for test in json {
            let p = ModlParser()
            do {
                let result = try p.parse(test.modl)
                let expected = test.expectedJson.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
                XCTAssert(result == expected, "Test: \(test.modl)\nExpected: \(expected)\nGot: \(result ?? "NA")")
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
