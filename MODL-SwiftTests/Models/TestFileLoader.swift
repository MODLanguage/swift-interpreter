//
//  TestFileLoader.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

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
    func copyFiles() {
        if let docDirectory = FileManager.default.urls(for: .documentDirectory,
                                                       in: .userDomainMask).first {
            do {
                let rootTestFolder = "grammar_tests"
                let rootTestPath = docDirectory.appendingPathComponent(rootTestFolder)
                try FileManager.default.createDirectory(at: rootTestPath, withIntermediateDirectories: false, attributes: nil)
                let newFolder = "test_import_dir"
                let newFolderUrl = rootTestPath.appendingPathComponent(newFolder)
                for file in ["1", "2", "3", "a", "b", "c", "demo_config", "import_config"] {
                    if let bundleFile = Bundle(for: FileLoadTests.self).url(forResource: file, withExtension: "modl") {
                        try FileManager.default.copyItem(at: bundleFile, to: rootTestPath.appendingPathComponent(file + ".modl"))
                    }
                }
                let subfolderFile = "test_import"
                if let bundleFile = Bundle(for: FileLoadTests.self).url(forResource: subfolderFile, withExtension: "txt") {
                    try FileManager.default.createDirectory(at: newFolderUrl, withIntermediateDirectories: false, attributes: nil)
                    try FileManager.default.copyItem(at: bundleFile, to: newFolderUrl.appendingPathComponent(subfolderFile + ".txt"))
                }
            } catch {
                print(error)
            }
        }
    }
}
