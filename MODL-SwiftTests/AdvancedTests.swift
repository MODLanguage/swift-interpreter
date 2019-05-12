//
//  AdvancedTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 09/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest

class AdvancedTests: XCTestCase {
    var jsonTests: [MODLTest]?

    override func setUp() {
        jsonTests = MODLTest.getAllTests(self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJustClass() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let simpleClassTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.classes.rawValue) ?? false) && modl.testedFeatures?.count == 1
        }
        performTests(simpleClassTests)
    }
    
    func testAssignClass() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let assignClassTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.classes.rawValue) ?? false) && modl.testedFeatures?.count == 2 && (modl.testedFeatures?.contains(FeatureTestTypes.assign.rawValue) ?? false)
        }
        performTests(assignClassTests)
    }

    
    func performTests(_ tests: [MODLTest]) {
        for test in tests {
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
                    //import and export JSON so format matches parser
                    let data = Data(expected.utf8)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dataOutput = try JSONSerialization.data(withJSONObject: json, options: [])
                    let stringOutput = String(data: dataOutput, encoding: .utf8)
                    XCTAssert(result == stringOutput, "\nExpected: \(stringOutput ?? "")\nGot: \(result)")
                }
            } catch {
                XCTFail("Error caught \(error.localizedDescription)")
            }
            print("******TEST END********\n************")
        }
        print("TOTAL TESTS: \(tests.count)")
    }
}
