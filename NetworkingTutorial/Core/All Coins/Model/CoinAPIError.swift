//
//  CoinAPIError.swift
//  NetworkingTutorial
//
//  Created by Auto on 26/12/23.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFaliure
    case requestFailed(description: String)
    case invalidStatusCode(description: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .jsonParsingFaliure: return "Failed to parse JSON"
        case let .requestFailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid status code \(statusCode)"
        case let .unknownError(error): return "An unknown error occuard \(error.localizedDescription)"
        }
        
    }
}
