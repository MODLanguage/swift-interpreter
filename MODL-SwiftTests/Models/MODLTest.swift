//
//  MODLTest.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 07/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation
import XCTest

enum FeatureTestTypes: String {
    case conditional
    case load
    case classes = "class"
    case assign 
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
        return [.conditional, .load, .classes, .assign, .method, .objectReference, .puny, .stringMethod]
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
    
    enum CodingKeys: String, CodingKey {
        case comment
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
                let newTest = MODLTest(modl: test.modl, minModl: test.minModl, expectedJson: value as String, comment: test.comment, testedFeatures: test.testedFeatures)
                return newTest
            }
            return testCleared
        } catch {
            return nil
        }
    }
}