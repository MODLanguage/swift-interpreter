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
            let output = try? parser.parseToRawModl(fileText)
            //TODO: add to cache
            return output
        }
        return nil
    }
    
    func loadFileText(_ path: String) throws -> String? {
        let filePath = adjustFilePath(path)
        if filePath.hasPrefix("http:") {
            //TODO: load from URI
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
}
