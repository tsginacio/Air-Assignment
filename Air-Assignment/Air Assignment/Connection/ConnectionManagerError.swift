//
//  NetworkError.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import Foundation

enum ConnectionManagerError: Error , LocalizedError{
    case invalidUrl
    case noResponseData
    case serverError(statusCode: Int)
    case errorOnDecodingResponse
    case internetConnectionError
    case unknownError
    
    var errorDescription: String? {
            switch self {
                case .invalidUrl:
                    return "Invalid URL."
                case .noResponseData:
                    return "No data was returned from the server."
                case .errorOnDecodingResponse:
                    return "Decoding error."
                case .serverError(let statusCode):
                    return "Server error status code: \(statusCode)."
                case .internetConnectionError:
                    return "A network failure occurred, please check your internet connection."
                case .unknownError:
                    return "An unknown error occurred."
            }
        }
}
