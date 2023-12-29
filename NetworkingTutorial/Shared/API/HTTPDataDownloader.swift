//
//  HTTPDataDownloader.swift
//  NetworkingTutorial
//
//  Created by Auto on 29/12/23.
//

import Foundation

protocol HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData<T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw CoinAPIError.requestFailed(description: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoinAPIError.requestFailed(description: "Request failed")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw CoinAPIError.invalidStatusCode(description: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch {
            print("Debug: Error \(error)")
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
}
