//
//  DictionaryUtility.swift
//  Marvel
//
//  Created by Nidhi Goyal on 01/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

extension Dictionary {
    public func merged(another: [Key: Value]) -> Dictionary {
        var result: [Key: Value] = [:]
        for (key, value) in self {
            result[key] = value
        }
        for (key, value) in another {
            result[key] = value
        }
        return result
    }
}
