//
//  StringTransformer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 13/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct StringTransformer {
    func transformString(_ inputString: String?) -> ModlValue? {
        guard var uwInput = inputString else {
            //TODO: Return ModlNull?
            return nil
        }
        let prim = ModlOutputObject.Primitive()

    //*** Check if bool value
        if uwInput.lowercased() == "true" {
            prim.value = true
            return prim
        } else if uwInput.lowercased() == "false" {
            prim.value = false
            return prim
        }
        
    //*** Escape as per string-replacement.txt
        //TODO: is this necessary?
        uwInput = StringEscapeReplacer().replace(uwInput)
    //*** Replace Unicode:
        //TODO: swift might make this unnec

// Implement Elliott's algorithm for string transformation :
    // 1 : Find all parts of the sting that are enclosed in graves, e.g `test` where neither of the graves is prefixed with an escape character ~ (tilde) or \ (backslash).
        let graveParts = getGraveRangesFromString(uwInput)
        for range in graveParts {
            var refKey = String(uwInput[range])
            if !refKey.hasPrefix("`%") {
                //skip if not object ref
                continue
            }
            if refKey.hasPrefix("`") {
                refKey.removeFirst()
            }
            if refKey.hasSuffix("`") {
                refKey.removeLast()
            }
            let mValue = checkObjectReferencing(refKey)
        }
        prim.value = inputString
        return prim
    }
    
    private func getGraveRangesFromString(_ stringToTransform: String) -> [Range<String.Index>] {
        // Find all parts of the sting that are enclosed in graves, e.g `test` where neither of the graves is prefixed with an escape character ~ (tilde) or \ (backslash).
        let pattern = "(?<![\\\\~])`%[^`]*`"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(stringToTransform.startIndex..., in: stringToTransform)
        let matches = regex?.matches(in: stringToTransform, options: [], range: range).compactMap{ textResult -> Range<String.Index>? in
            return Range(textResult.range, in: stringToTransform)
        }
        return matches ?? []
    }

    private func checkObjectReferencing(_ keyToCheck: String) -> ModlValue? {
        var mKey = keyToCheck
        if mKey.hasPrefix("%") {
            mKey.removeFirst()
        }
        var subject = mKey
        var method: String? = nil
        if let dotIndex = mKey.firstIndex(of: ".") {
            subject = String(mKey[..<dotIndex])
            method = String(mKey[dotIndex...])
        }
        if let referencedValue = valueForReference(subject) {
            switch referencedValue {
            case let primitive as ModlPrimitive:
                if let str = primitive.value as? String {
                    subject = str
                } else if let num = primitive.value as? Decimal {
                    if method?.count == 0 {
                        return referencedValue
                    }
                    subject = "\(num)"
                }
            default:
                return referencedValue
            }
        } else {
            let prim = ModlOutputObject.Primitive()
            prim.value = keyToCheck
            return prim
        }
        return nil
    }
    
    
    private func valueForReference(_ objectName: String) -> ModlValue? {
        return nil
    }
}
