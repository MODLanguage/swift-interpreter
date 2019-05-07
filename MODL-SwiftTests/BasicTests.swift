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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "basic", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            jsonTests = try JSONDecoder().decode([MODLTest].self, from: data)
        } catch {
            XCTFail("Fail creating tests from json input")
        }
    }
    
    
    func testAllJSONExamples() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        for test in json {
            print("******TEST START********\n************")
            print("Test: \(test.modl)")
            let p = ModlParser()
            let result = p.parse(test.modl)
            let expected = test.expectedJson.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
            XCTAssert(result == expected, "\nExpected: \(expected)\nGot: \(result)")
            print("******TEST END********\n************")
        }
        print("TOTAL TESTS: \(jsonTests?.count ?? 0)")
    }

}
