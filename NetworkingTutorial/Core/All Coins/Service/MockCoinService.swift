//
//  MockCoinService.swift
//  NetworkingTutorial
//
//  Created by Auto on 31/12/23.
//

import Foundation

class MockCoinService: CoinServiceProtocol {
    func fetchCoins() async throws -> [CoinModel] {
        let bitcoin = CoinModel(id: "bitcoin", name: "Bitcoin", symbol: "BTC", currentPrice: 26000, marketCapRank: 1)
        let citcoin = CoinModel(id: "citcoin", name: "Citcoin", symbol: "CTC", currentPrice: 25000, marketCapRank: 2)
        let ditcoin = CoinModel(id: "ditcoin", name: "Ditcoin", symbol: "DTC", currentPrice: 24000, marketCapRank: 3)
        
        return [bitcoin, citcoin, ditcoin]
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetailsModel? {
        let bdescription = Description(text: "This is Bitcoin")

        let bitcoinDetails = CoinDetailsModel(id: "bitcoin", name: "Bitcoin", symbol: "BTC", description: bdescription)
        return bitcoinDetails
    }
}
