/*
 MIT License
 
 Copyright (c) 2018 NUM Technology Ltd
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  AdvancedTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 09/05/2019.
//

import XCTest
@testable import MODL_Interpreter

class AdvancedTests: XCTestCase {
    var jsonTests: [MODLTest]?

    override func setUp() {
        jsonTests = MODLTestManager.getAllTests(self)
    }

    override func tearDown() {
        jsonTests = nil
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
    
    func testConditional() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let objRefClassTests = json.filter { (modl) -> Bool in
            return (modl.testedFeatures?.contains(FeatureTestTypes.conditional.rawValue) ?? false) && modl.testedFeatures?.count == 1
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
            return !modlFeature.contains(FeatureTestTypes.load.rawValue) && !modlFeature.contains(FeatureTestTypes.method.rawValue)
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
            return modlFeature.contains("problem") && !modlFeature.contains(FeatureTestTypes.load.rawValue)
        }
        MODLTestManager.performTests(allButTests)
    }

    func testSuperclassInferenceCases() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let allButTests = json.filter { (modl) -> Bool in
            guard let modlFeature = modl.testedFeatures else {
                return false
            }
            return modlFeature.contains(FeatureTestTypes.superclassInference.rawValue)
        }
        MODLTestManager.performTests(allButTests)
    }
    
    func testMethods() {
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let methodTests = json.filter { (modl) -> Bool in
            guard let modlFeature = modl.testedFeatures else {
                return false
            }
            return modlFeature.contains(FeatureTestTypes.method.rawValue)
        }
        MODLTestManager.performTests(methodTests)
    }
}
