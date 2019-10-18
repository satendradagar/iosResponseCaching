
//
//  URLRequestProtocol.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//


import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public protocol URLRequestConvertible {

    /// - returns: A URL request.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    /// The URL request.
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    public func asURLRequest() throws -> URLRequest { return self }
}

public protocol RequestProtocol: URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Parameters? { get }
    var headers: HTTPHeaders? { get }
}



