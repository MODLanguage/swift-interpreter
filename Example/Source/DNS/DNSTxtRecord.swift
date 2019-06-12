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
//  DNSTxtRecord.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import Foundation
import dnssd

struct DNSTxtRecord {
    
    typealias DNSLookupHandler = ([String: String]?) -> Void
    
    static func lookup(_ domainName: String, completionHandler: @escaping DNSLookupHandler) {
        var mutableCompletionHandler = completionHandler // completionHandler needs to be mutable to be used as inout param
        let callback: DNSServiceQueryRecordReply = {
            (sdRef, flags, interfaceIndex, errorCode, fullname, rrtype, rrclass, rdlen, rdata, ttl, context) -> Void in
            // dereference completionHandler from pointer since we can't directly capture it in a C callback
            guard let completionHandlerPtr = context?.assumingMemoryBound(to: DNSLookupHandler.self) else { return }
            let completionHandler = completionHandlerPtr.pointee
            // map memory at rdata to a UInt8 pointer
            guard let txtPtr = rdata?.assumingMemoryBound(to: UInt8.self) else {
                completionHandler(nil)
                return
            }
            // advancing pointer by 1 to skip bad character at beginning of record
            let txt = String(cString: txtPtr.advanced(by: 1))
            // parse name=value txt record into dictionary
            var record: [String: String] = [:]
            let recordParts = txt.components(separatedBy: "=")
            record[recordParts[0]] = recordParts[1]
            completionHandler(record)
        }
        
        // MemoryLayout<T>.size can give us the necessary size of the struct to allocate
        let serviceRef: UnsafeMutablePointer<DNSServiceRef?> = UnsafeMutablePointer.allocate(capacity: MemoryLayout<DNSServiceRef>.size)
        // pass completionHandler as context object to callback so that we have a way to pass the record result back to the caller
        DNSServiceQueryRecord(serviceRef, 0, 0, domainName, UInt16(kDNSServiceType_TXT), UInt16(kDNSServiceClass_IN), callback, &mutableCompletionHandler);
        DNSServiceProcessResult(serviceRef.pointee)
        DNSServiceRefDeallocate(serviceRef.pointee)
    }
}
