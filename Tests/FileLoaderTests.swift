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
//  FileLoadTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 06/06/2019.
//

import XCTest
@testable import Interpreter

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
