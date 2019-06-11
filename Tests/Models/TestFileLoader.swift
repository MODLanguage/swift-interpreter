//
//  TestFileLoader.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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
                let newFolder = "test_import_dir"
                let newFolderUrl = rootTestPath.appendingPathComponent(newFolder)
                for file in ["1", "2", "3", "a", "b", "c", "demo_config", "import_config"] {
                    if let bundleFile = bundle.url(forResource: file, withExtension: "modl") {
                        try FileManager.default.copyItem(at: bundleFile, to: rootTestPath.appendingPathComponent(file + ".modl"))
                    }
                }
                try FileManager.default.createDirectory(at: newFolderUrl, withIntermediateDirectories: false, attributes: nil)
                for file in ["test_import", "nested_import1", "nested_import2", "nested_import3"] {
                    if let bundleFile = bundle.url(forResource: file, withExtension: "txt") {
                        try FileManager.default.copyItem(at: bundleFile, to: newFolderUrl.appendingPathComponent(file + ".txt"))
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
