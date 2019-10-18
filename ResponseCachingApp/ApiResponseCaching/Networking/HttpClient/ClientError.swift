//
//  ClientError.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

typealias ClientErrorHandler = (ClientError?) -> Void

struct ClientError: Error {
    
    var localizedDescription: String
    
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
    
}
