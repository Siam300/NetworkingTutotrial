//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    private let service = CoinDataService()
    
    init() {
        fetchPrice(coin: "bitcoin")
    }
    
    func fetchPrice(coin: String) {
        service.fetchPrice(coin: coin) { priceFromService in
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "\(priceFromService)"
            }
        }
    }
}


