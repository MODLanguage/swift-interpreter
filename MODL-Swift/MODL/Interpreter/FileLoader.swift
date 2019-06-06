//
//  ModlFileLoader.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 06/06/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct FileCacheItem {
    let expiryTime: Date
    let fileData: ModlListenerObject
}

class FileLoader {
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
        cache.removeValue(forKey: filePath)
        if let fileText = try loadFileText(filePath) {
            let parser = ModlParser()
            if let output = try? parser.parseToRawModl(fileText) {
                let fileItem = FileCacheItem(expiryTime: Date().addingTimeInterval(60 * 60 * 60), fileData: output)
                cache[filePath] = fileItem
                cacheKeyOrder.append(filePath)
                return output
            }
        }
        return nil
    }
    
    func loadFileText(_ path: String) throws -> String? {
        let filePath = adjustFilePath(path)
        if filePath.hasPrefix("http:") || filePath.hasPrefix("https:") {
            if let url = URL(string: filePath) {
                return try String(contentsOf: url)
            }
        } else {
            //TODO: load from file
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
    
    func loadedFiles() -> ModlArray {
        var output = ModlOutputObject.Array()
        output.values = cacheKeyOrder.map({ (key) -> ModlPrimitive in
            return ModlOutputObject.Primitive(key)
        })
        return output
    }
}
