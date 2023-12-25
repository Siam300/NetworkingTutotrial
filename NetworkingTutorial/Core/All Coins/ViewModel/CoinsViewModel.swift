//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [CoinModel] ()
    private let service = CoinDataService()
    
    init() {
        //fetchPrice(coin: "bitcoin")
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
        }
    }
}


