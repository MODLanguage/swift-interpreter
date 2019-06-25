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
//  MODLTest.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 07/05/2019.
//

import Foundation
import XCTest

@testable import MODL_Interpreter

enum FeatureTestTypes: String {
    case conditional
    case load
    case classes = "class"
    case assign
    case superclassInference = "superclass_inference"
    case method
    case puny
    case stringMethod = "string_method"
    case objectReference = "object_ref"
    case array
    case map
    case pair
    case nbArray
    case version
    case graves
    case bool
    case null
    case comments
    
    static var advancedFeatures: [FeatureTestTypes] {
        return [.conditional, .load, .classes, .assign, .method, .objectReference, .puny, .stringMethod, .graves]
    }
    
    static var basicFeatures: [FeatureTestTypes] {
        return [.array, .map, .pair, .nbArray, .bool, .null]
    }
}

struct MODLTest: Codable {
    let modl: String
    let minModl: String
    let expectedJson: String
    let comment: String?
    let testedFeatures: [String]?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case comment
        case id = "id"
        case modl = "input"
        case minModl = "minimised_modl"
        case expectedJson = "expected_output"
        case testedFeatures = "tested_features"
    }
    
    func isBasicTest() -> Bool{
        guard let uwFeatures = testedFeatures else {
            return false
        }
        let searchSet: Set<String> = Set(FeatureTestTypes.advancedFeatures.map{$0.rawValue})
        return searchSet.isDisjoint(with: uwFeatures)
    }
    
    func isAdvancedTest() -> Bool {
        guard testedFeatures != nil else {
            return false
        }
        return !isBasicTest()
    }
}

struct MODLTestManager {
    static func getAllTests(_ testObject: XCTestCase) -> [MODLTest]? {
        let bundle = Bundle(for: type(of: testObject))
        guard let fileUrl = bundle.url(forResource: "base_tests", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let tests = try JSONDecoder().decode([MODLTest].self, from: data)
            let testCleared = tests.map { (test) -> MODLTest in
                let value = NSMutableString(string: test.expectedJson.replacingOccurrences(of: "\n", with: ""))
                let pattern = "\\s(?=(\"[^\"]*\"|[^\"])*$)"
                let regex = try? NSRegularExpression(pattern: pattern)
                regex?.replaceMatches(in: value, options: .reportProgress, range: NSRange(location: 0,length: value.length), withTemplate: "")
                let newTest = MODLTest(modl: test.modl, minModl: test.minModl, expectedJson: value as String, comment: test.comment, testedFeatures: test.testedFeatures,id: test.id)
                return newTest
                }.filter { (test) -> Bool in
                    test.modl != "DELETED"
            }
            return testCleared
        } catch {
            return nil
        }
    }
    
    static func getErrorTests(_ testObject: XCTestCase) -> [String]? {
        let bundle = Bundle(for: type(of: testObject))
        guard let fileUrl = bundle.url(forResource: "error_tests", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            return nil
        }
    }

    
    static func performTests(_ tests: [MODLTest]) {
        for test in tests {
//            print("******TEST START********\n************")
//            print("Test: \(test.modl)")
            let p = Interpreter()
            do {
                let result = try p.parseToJson(test.modl)
                let expected = test.expectedJson
                if expected.count == 0 {
                    //empty test
                    XCTAssert(result == expected, "\nExpected: \(expected)\nGot: \(result)")
                } else {
                    //import and export JSON so format matches parser
//                    let data = Data(expected.utf8)
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    let dataOutput = try JSONSerialization.data(withJSONObject: json, options: [])
//                    let stringOutput = String(data: dataOutput, encoding: .utf8)
                    XCTAssert(result == test.expectedJson, "\nTest: \(test.id)\n \(test.modl)\nExpected: \(test.expectedJson)\nGot: \(result)")
                }
            } catch {
                XCTFail("Caught error for test \(test.modl). \n\(error.localizedDescription)")
            }
//            print("******TEST END********\n************")
        }
        print("TOTAL TESTS: \(tests.count)")
    }

}
