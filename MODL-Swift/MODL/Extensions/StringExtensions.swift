//
//  StringExtensions.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 23/05/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import Foundation

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
