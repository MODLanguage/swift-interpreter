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
//  InterpreterTests.swift
//  InterpreterTests
//
//  Created by Nicholas Jones on 11/06/2019.
//

import XCTest
@testable import MODL_Interpreter

class InterpreterTests: XCTestCase {
    var jsonTests: [MODLTest]?
    var errorTests: [String]?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testFileLoader = TestFileLoader()
        testFileLoader.removeTestFiles()
        testFileLoader.copyFiles(self)
        jsonTests = MODLTestManager.getAllTests(self)
        errorTests = MODLTestManager.getErrorTests(self)
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
    
    func testErrorExamples() {
        guard let tests = errorTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        for test in tests {
//            print(test)
            let p = Interpreter()
            XCTAssertThrowsError(try p.parseToJson(test), "Test should throw error: \(test)") { (error) in
            
            }
        }
        print("Total tests: \(tests.count)")
    }
    
    func testSpecificID() {
        let testingIds = [295]
        guard let json = jsonTests else {
            XCTFail("Fail creating tests from json input")
            return
        }
        let allButTests = json.filter { (modl) -> Bool in
            guard let modlId = modl.id, let iMId = Int(modlId) else {
                return false
            }
            return testingIds.contains(iMId)
        }
        MODLTestManager.performTests(allButTests)
    }
    
    func testNum() {
        let modl = """
            _C=gb;
            _L=en;
            _Q=numexample.com;
            _D=numexample.com;
            _DV=iPhone 7;
            _TZ=GMT;
            _GPS=53.473997,-2.237334;
            *load="http://modules.num.uk/1/rcf.txt";
            o=NUM Example Co:Example Strapline:[t=Call us:441270123456;fb=examplefacebook;tw=exampletwitter;in=exampleinstagram]
"""
        let p = Interpreter()
        do {
            let result = try p.parseToJson(modl)
            let expected = testNumResult.replacingOccurrences(of: "\n", with: "")
            XCTAssert(result == expected)
        } catch {
            XCTFail("Parse error: \(error.localizedDescription)")
        }
    }
}

let testNumResult = """
{
"organisation": {
"name": "NUM Example Co",
"slogan": "Example Strapline",
"contacts": [
{
"telephone": {
"description": "Call us",
"value": "441270123456",
"object_type": "media",
"object_display_name": "Telephone",
"description_default": "Call",
"prefix": "tel://",
"media_type": "core"
}
},
{
"facebook": {
"value": "examplefacebook",
"object_type": "media",
"object_display_name": "Facebook",
"description_default": "View Facebook profile",
"prefix": "https://www.facebook.com/",
"media_type": "3p"
}
},
{
"twitter": {
"value": "exampletwitter",
"object_type": "media",
"object_display_name": "Twitter",
"description_default": "View Twitter profile",
"prefix": "https://www.twitter.com/",
"media_type": "3p",
"value_prefix": "@"
}
},
{
"instagram": {
"value": "exampleinstagram",
"object_type": "media",
"object_display_name": "Instagram",
"description_default": "View Instagram profile",
"prefix": "https://www.instagram.com/",
"media_type": "3p"
}
}
],
"object_type": "entity",
"object_display_name": "Organization",
"description_default": "View Organization"
}
}
"""
