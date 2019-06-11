//
//  LoadTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest
@testable import Interpreter

class LoadTests: XCTestCase {
    var jsonTests: [MODLTest]?
    
    override func setUp() {
        let testFileLoader = TestFileLoader()
        testFileLoader.removeTestFiles()
        testFileLoader.copyFiles(self)
        jsonTests = MODLTestManager.getAllTests(self)
    }

    override func tearDown() {
        jsonTests = nil
        TestFileLoader().removeTestFiles()
    }

    func testJustLoad() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let loadTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.load.rawValue) ?? false) && modl.testedFeatures?.count == 1
        }
        MODLTestManager.performTests(loadTests)
    }
    
    func testAllLoad() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let loadTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.load.rawValue) ?? false) && !(modl.testedFeatures?.contains(FeatureTestTypes.method.rawValue) ?? true)
        }
        MODLTestManager.performTests(loadTests)
    }
    
    func testLoadProblem() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let loadTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains("problem") ?? false) && (modl.testedFeatures?.contains(FeatureTestTypes.load.rawValue) ?? true)
        }
        MODLTestManager.performTests(loadTests)
    }
}
