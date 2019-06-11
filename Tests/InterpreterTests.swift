//
//  InterpreterTests.swift
//  InterpreterTests
//
//  Created by Nicholas Jones on 11/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest
@testable import Interpreter

class InterpreterTests: XCTestCase {
    var jsonTests: [MODLTest]?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testFileLoader = TestFileLoader()
        testFileLoader.removeTestFiles()
        testFileLoader.copyFiles(self)
        jsonTests = MODLTestManager.getAllTests(self)
    }
    
    override func tearDown() {
        jsonTests = nil
        TestFileLoader().removeTestFiles()
    }
    
    func testAllJSONExamples() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        MODLTestManager.performTests(json)
    }

}
