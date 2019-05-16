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
        jsonTests = MODLTestManager.getAllTests(self)
    }

    override func tearDown() {
        jsonTests = nil
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
        MODLTestManager.performTests(simpleClassTests)
    }
    
    func testAssignClass() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let assignClassTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.classes.rawValue) ?? false) && modl.testedFeatures?.count == 2 && (modl.testedFeatures?.contains(FeatureTestTypes.assign.rawValue) ?? false)
        }
        MODLTestManager.performTests(assignClassTests)
    }
    
    func testObjRef() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let objRefClassTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.objectReference.rawValue) ?? false) && modl.testedFeatures?.count == 1
        }
        MODLTestManager.performTests(objRefClassTests)
    }
    
    func testAllButMostAdvanced() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let allButTests = json.filter { (modl) -> Bool in
            guard let modlFeature = modl.testedFeatures else {
                return false
            }
            return !(modlFeature.contains(FeatureTestTypes.conditional.rawValue) || modlFeature.contains(FeatureTestTypes.load.rawValue) || modlFeature.contains(FeatureTestTypes.method.rawValue) || modlFeature.contains(FeatureTestTypes.puny.rawValue) || modlFeature.contains(FeatureTestTypes.stringMethod.rawValue))
        }
        MODLTestManager.performTests(allButTests)
    }
    
    func testProblemCases() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let allButTests = json.filter { (modl) -> Bool in
            guard let modlFeature = modl.testedFeatures else {
                return false
            }
            return modlFeature.contains("problem")
        }
        MODLTestManager.performTests(allButTests)
    }

}
