//
//  CoinModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 25/12/23.
//

import Foundation

struct CoinModel: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Double
    let marketCapRank: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
    }
}
