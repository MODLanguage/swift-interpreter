//
//  FileLoadTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import XCTest
@testable import MODL_Swift

class FileLoaderTests: XCTestCase {
        var sut: FileLoader? = nil
    
    override func setUp() {
        let testFileLoader = TestFileLoader()
        sut = FileLoader()
        testFileLoader.removeTestFiles()
        testFileLoader.copyFiles(self)
    }

    override func tearDown() {
        sut = nil
        TestFileLoader().removeTestFiles()
    }

    func testLoadFile() {
        for fileName in ["1", "2", "3", "a", "b", "c", "demo_config", "import_config"] {
            let fileText = try? sut?.loadFileText("grammar_tests/\(fileName)")
            XCTAssert( fileText != nil )
        }
    }
    
    func testForceLoadFilePath() {
        for fileName in ["1", "2", "3", "a", "b", "c", "demo_config", "import_config"] {
            let fileText = try? sut?.loadFileText("grammar_tests/\(fileName)!")
            XCTAssert( fileText != nil )
        }
    }
    
    func testSubFolderLoadFile() {
        let path = "test_import_dir/test_import.txt"
        let fileText = try? sut?.loadFileText("grammar_tests/\(path)!")
        XCTAssert( fileText != nil )
    }

    func testMODLObjectLoad() {
        let fileObj = try? sut?.loadFileObject("grammar_tests/1")
        XCTAssert(fileObj != nil)
        XCTAssert(fileObj?.structures.count == 1)
    }
}
