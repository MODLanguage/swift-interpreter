//
//  StringTransformer.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 13/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

struct StringTransformer {
    let objectRegExPattern = "((`?\\%[0-9][0-9.][a-zA-Z0-9.(),]*`?)|(`?\\%[0-9][0-9]*`?)|(`?\\%[_a-zA-Z][_a-zA-Z0-9.%(),]*`?)|(`.*`\\.[_a-zA-Z0-9.(),%]+)|(`.*`))"

    func transformKeyString(_ inputString: String?, objectMgr: ModlObjectReferenceManager?) -> String? {
        let prim = transformString(inputString, objectMgr: objectMgr) as? ModlPrimitive
        return prim?.value as? String ?? inputString
    }
    
    func transformString(_ inputString: String?, objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
        guard var uwInput = refContinueQuickProcess(inputString) else {
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

        var startIndex: String.Index = uwInput.startIndex
        var finished = false
        while !finished {
            if let ref = getObjectRangesMatch(uwInput, start: startIndex) {
                var refKey = String(uwInput[ref])
                if refKey.hasPrefix("`") {
                    refKey.removeFirst()
                }
                if refKey.hasSuffix("`") {
                    refKey.removeLast()
                }
                let mValue = checkObjectReferencing(keyToCheck: refKey, objectMgr: objectMgr)
                if refKey == uwInput {
                    //the entire key matches the grave key so just return referenced object
                    return mValue
                } else if let primitive = mValue as? ModlPrimitive, let replacement = primitive.asString() {
                    //need to get prim value of returned item and replace grave parts with it
                    uwInput = uwInput.replacingCharacters(in: ref, with: replacement)
                } else {
                    //TODO: is there anything else that can happen? Can part of a string in graves become an array?
                    //at very least remove the characters that cause it to be loop checked forever
//                    if refKey.hasPrefix("%") {
//                        uwInput = uwInput.replacingCharacters(in: ref, with: refKey.dropFirst())
//                    }
                    uwInput = uwInput.replacingOccurrences(of: "`", with: "", options: [], range: ref)
                }
                if startIndex == ref.lowerBound {
                    finished = true
                } else {
                    startIndex = ref.lowerBound
                }
                if mValue == nil {
                    finished = true
                }
            } else {
                finished = true
            }
        }
        prim.value = uwInput//.replacingOccurrences(of: "`", with: "")
        return prim
    }
    
    private func refContinueQuickProcess(_ inputString: String?) -> String? {
        guard let uwStr = inputString, uwStr.contains("%") || uwStr.contains("`")  else {
            return nil
        }
        return uwStr
    }
    
    private func getObjectRangesMatch(_ stringToTransform: String, start: String.Index) -> Range<String.Index>? {
        // Find all parts of the sting that are enclosed in graves, e.g `test` where neither of the graves is prefixed with an escape character ~ (tilde) or \ (backslash).
        let regex = try? NSRegularExpression(pattern: objectRegExPattern, options: [])
        let range = NSRange(start..., in: stringToTransform)
        if let match = regex?.firstMatch(in: stringToTransform, options: [], range: range) {
            return Range(match.range, in: stringToTransform)
        }
        return nil
    }

    private func checkObjectReferencing(keyToCheck: String, objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
        guard let uwObjMgr = objectMgr, keyToCheck.count > 0 else {
            return nil
        }

        var mKey = keyToCheck
        if mKey.hasPrefix("%") {
            mKey.removeFirst()
        }
        var methods = mKey.split(separator: ".").map{String($0)}
        let subject = String(methods.remove(at: 0)) //take off the subject and leave the methods
        var refObject: ModlValue?
        if let numReference = Int(subject) {
            refObject = uwObjMgr.getIndexedVariable(numReference)
        } else {
            refObject = objectMgr?.getKeyedVariable(subject)
        }
        if methods.count == 0 {
            return refObject
        } else {
            return handleNestedObject(refObject, methods: methods, objectMgr: objectMgr)
        }
    }

    
    private func handleNestedObject(_ refObject: ModlValue?, methods: [String], objectMgr: ModlObjectReferenceManager?) -> ModlValue? {
        var newRef = refObject
        var index = 0
        var isFinished = index >= methods.count
        
        while !isFinished {
            var method = String(methods[index])
            if let transformed = transformString(method, objectMgr: objectMgr) as? ModlPrimitive {
                method = transformed.asString() ?? method
            }
            if let numMethod = Int(method), let refArray = newRef as? ModlArray {
                newRef = refArray.values[numMethod]
            } else if let refMap = newRef as? ModlMap {
                newRef = refMap.value(forKey: method)
            } else if let refPair = newRef as? ModlPair, refPair.key == method {
                newRef = refPair.value
            } else if let refPrim = newRef as? ModlPrimitive, let primValue = refPrim.asString() {
                let methodChain = methods[index...].joined(separator: ".")
                if methodChain.count > 0 {
                    refPrim.value = primValue + "." + methodChain
                }
                newRef = refPrim
                isFinished = true
            }
            
            index += 1
            isFinished = index >= methods.count
        }
        return newRef
    }
    
    private func valueForReference(_ objectName: String) -> ModlValue? {
        //replace with using the object manager to get modl value
        return nil
    }
}
