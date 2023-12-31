//
//  MockCoinService.swift
//  NetworkingTutorial
//
//  Created by Auto on 31/12/23.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    
    var mockData: Data?
    var mockError: CoinAPIError?
    
    func fetchCoins() async throws -> [CoinModel] {
        if let mockError { throw mockError }
        
        do {
            let coins = try JSONDecoder().decode([CoinModel].self, from: mockData ?? mockCoinsData_marketCapDesc)
            return coins
        } catch {
            throw error as? CoinAPIError ?? .unknownError(error: error)
        }
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetailsModel? {
        let bdescription = Description(text: "This is Bitcoin")

        let bitcoinDetails = CoinDetailsModel(id: "bitcoin", name: "Bitcoin", symbol: "BTC", description: bdescription)
        return bitcoinDetails
    }
}
