//
//  URLSessionProtocol.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    
    func resume()
    func cancel()
    
}
