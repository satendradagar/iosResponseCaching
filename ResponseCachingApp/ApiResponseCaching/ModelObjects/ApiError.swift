//
//  ApiError.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

struct ApiError: Decodable {
    let status: String?
    let error: String?
}

enum EncodingDecodingErrors: Error{

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

}
