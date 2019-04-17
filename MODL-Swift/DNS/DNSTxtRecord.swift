//
//  DNSTxtRecord.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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
