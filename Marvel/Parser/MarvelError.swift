//
//  MarvelError.swift
//  Marvel
//
//  Created by Nidhi Goyal on 02/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

public struct MarvelError: Error {
    
    public enum ErrorKind: CustomStringConvertible {
        case invalidAppOnlyBearerToken
        case responseError(code: Int)
        case invalidJSONResponse
        case badOAuthResponse
        case urlResponseError(status: Int, headers: [AnyHashable: Any], errorCode: Int)
        case jsonParseError
        
        public var description: String {
            switch self {
            case .invalidAppOnlyBearerToken:
                return "invalidAppOnlyBearerToken"
            case .invalidJSONResponse:
                return "invalidJSONResponse"
            case .responseError(let code):
                return "responseError(code: \(code))"
            case .badOAuthResponse:
                return "badOAuthResponse"
            case .urlResponseError(let code, let headers, let errorCode):
                return "urlResponseError(status: \(code), headers: \(headers), errorCode: \(errorCode)"
            case .jsonParseError:
                return "jsonParseError"
            }
        }
        
    }
    
    public var message: String
    public var kind: ErrorKind
    
    public var localizedDescription: String {
        return "[\(kind.description)] - \(message)"
    }
    
}
