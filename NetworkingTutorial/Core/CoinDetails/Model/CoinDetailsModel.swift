//
//  CoinDetailsModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 27/12/23.
//

import Foundation

struct CoinDetailsModel: Decodable {
    let id: String
    let name: String
    let symbol: String
    let description: Description
    
}

struct Description: Decodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "en"
    }
}
