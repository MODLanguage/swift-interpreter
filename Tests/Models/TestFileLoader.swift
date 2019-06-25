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
//  TestFileLoader.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//

import Foundation
import XCTest

struct TestFileLoader {
    func removeTestFiles() {
        do {
            if let docDirectory = FileManager.default.urls(for: .documentDirectory,
                                                           in: .userDomainMask).first {
                let rootTestFolder = "grammar_tests"
                let testURL = docDirectory.appendingPathComponent(rootTestFolder)
                var isDir : ObjCBool = false
                if FileManager.default.fileExists(atPath: testURL.path, isDirectory: &isDir) {
                    try FileManager.default.removeItem(at: testURL)
                }
            }
        } catch {
            print(error)
        }
    }
    
    //copy bundle files to documents directory to mirror real life use case
    func copyFiles(_ testObject: XCTestCase) {
        if let docDirectory = FileManager.default.urls(for: .documentDirectory,
                                                       in: .userDomainMask).first {
            do {
                let bundle = Bundle(for: type(of: testObject))
                let rootTestFolder = "grammar_tests"
                let rootTestPath = docDirectory.appendingPathComponent(rootTestFolder)
                try FileManager.default.createDirectory(at: rootTestPath, withIntermediateDirectories: false, attributes: nil)
                for file in ["1", "2", "3", "a", "b", "c", "demo_config", "import_config"] {
                    if let bundleFile = bundle.url(forResource: file, withExtension: "modl") {
                        try FileManager.default.copyItem(at: bundleFile, to: rootTestPath.appendingPathComponent(file + ".modl"))
                    }
                }
                let importFolder = "test_import_dir"
                let importFolderUrl = rootTestPath.appendingPathComponent(importFolder)
                try FileManager.default.createDirectory(at: importFolderUrl, withIntermediateDirectories: false, attributes: nil)
                for file in ["test_import", "nested_import1", "nested_import2", "nested_import3"] {
                    if let bundleFile = bundle.url(forResource: file, withExtension: "txt") {
                        try FileManager.default.copyItem(at: bundleFile, to: importFolderUrl.appendingPathComponent(file + ".txt"))
                    }
                }
                let fileFolder = "files"
                let fileFolderUrl = rootTestPath.appendingPathComponent(fileFolder)
                try FileManager.default.createDirectory(at: fileFolderUrl, withIntermediateDirectories: false, attributes: nil)
                for file in ["c-d"] {
                    if let bundleFile = bundle.url(forResource: file, withExtension: "txt") {
                        try FileManager.default.copyItem(at: bundleFile, to: fileFolderUrl.appendingPathComponent(file + ".txt"))
                    }
                }

            } catch {
                print(error)
            }
        }
    }
}
