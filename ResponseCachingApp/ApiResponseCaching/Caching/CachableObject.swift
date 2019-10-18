//
//  CachableObject.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

class CachableObject {
    let object: Any
    let identifier: String
    let totalBytes: UInt64
    var lastAccessDate: Date

    init(_ object: Any, identifier: String) {
        self.object = object
        self.identifier = identifier
        self.lastAccessDate = Date()

        self.totalBytes = {
           let s = MemoryLayout.size(ofValue: object)
            return UInt64(s)
        }()
    }

    func accessObject() -> Any {
        lastAccessDate = Date()
        return object
    }
}
