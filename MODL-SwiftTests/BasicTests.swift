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
        guard let fileUrl = bundle.url(forResource: "base_tests", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            jsonTests = try JSONDecoder().decode([MODLTest].self, from: data)
        } catch {
            XCTFail("Fail creating tests from json input: \(error)")
        }
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
        print("TOTAL TESTS: \(basic.count)")
    }

}
