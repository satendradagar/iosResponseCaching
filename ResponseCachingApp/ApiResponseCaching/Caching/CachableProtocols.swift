//
//  CachableProtocols.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

public protocol ResponseCache {
    
    /// Adds the Object to the cache with the given identifier.
    func add(_ object: Any, withIdentifier identifier: String)

    /// Removes the image from the cache matching the given identifier.
    func removeObject(withIdentifier identifier: String) -> Bool

    /// Removes all images stored in the cache.
    @discardableResult
    func removeAllObjects() -> Bool

    /// Returns the image in the cache associated with the given identifier.
    func object(withIdentifier identifier: String) -> Any?
}

/// The `ImageRequestCache` protocol extends the `ImageCache` protocol by adding methods for adding, removing and
/// fetching images from a cache given an `URLRequest` and additional identifier.
public protocol ImageRequestCache: ResponseCache {
    /// Adds the image to the cache using an identifier created from the request and identifier.
    func add(_ object: Any, for request: URLRequest, withIdentifier identifier: String?)

    /// Removes the image from the cache using an identifier created from the request and identifier.
    func removeObject(for request: URLRequest, withIdentifier identifier: String?) -> Bool

    /// Returns the image from the cache associated with an identifier created from the request and identifier.
    func object(for request: URLRequest, withIdentifier identifier: String?) -> Any?
}
