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
//  ModlFileLoader.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 06/06/2019.
//

import Foundation

struct FileCacheItem {
    let expiryTime: Date
    let fileData: ModlListenerObject
}

internal class FileLoader {
    private var cache: [String: FileCacheItem] = [:]
    private var cacheKeyOrder: [String] = []
    
    func loadFileObject(_ pathFromRoot: String) throws -> ModlListenerObject? {
        let forceReload = pathFromRoot.hasSuffix("!")
        let filePath = adjustFilePath(pathFromRoot)
        if !forceReload {
            if let cacheItem = cache[filePath] {
                if cacheItem.expiryTime < Date() {
                    return cacheItem.fileData
                }
            }
        }
        if let fileText = try loadFileText(filePath) {
            let parser = Interpreter()
            if let output = try? parser.parseToRawModl(fileText) {
                //only remove from cache if there is something to replace it with
                cache.removeValue(forKey: filePath)
                let fileItem = FileCacheItem(expiryTime: Date().addingTimeInterval(60 * 60 * 60), fileData: output)
                cache[filePath] = fileItem
                cacheKeyOrder.append(filePath)
                return output
            }
        } else {
            //if fails return whatever is in the cache
            return cache[filePath]?.fileData
        }
        return nil
    }
    
    func loadFileText(_ path: String) throws -> String? {
        var filePath = adjustFilePath(path)
        let insecurePrefix = "http:"
        if filePath.hasPrefix(insecurePrefix) {
            filePath = "https:" + filePath[insecurePrefix.endIndex...]
        }
        if filePath.hasPrefix("https:") {
            if let url = URL(string: filePath) {
                return try String(contentsOf: url)
            }
        } else {
                if let docDirectory = FileManager.default.urls(for: .documentDirectory,
                                                               in: .userDomainMask).first {
                    let fileUrl = docDirectory.appendingPathComponent(filePath)
                    let myData = try Data(contentsOf: fileUrl)
                    let strData = String(data: myData, encoding: .utf8)
                    return strData
                }
            }
        return nil
    }

    private func adjustFilePath(_ path: String) -> String {
        var filePath = path
        if filePath.hasSuffix("!") {
            filePath.removeLast()
        }
        if !(filePath.hasSuffix(".modl") || filePath.hasSuffix(".txt")) {
            filePath += ".modl"
        }
        return filePath
    }
    
    func referenceInstruction() -> ModlArray {
        var output = ModlOutputObject.Array()
        output.values = cacheKeyOrder.map({ (key) -> ModlPrimitive in
            return ModlOutputObject.Primitive(key)
        })
        return output
    }
}
