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
        cache.removeValue(forKey: filePath)
        if let fileText = try loadFileText(filePath) {
            let parser = Interpreter()
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
