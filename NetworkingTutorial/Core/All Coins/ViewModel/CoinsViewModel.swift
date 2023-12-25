//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [CoinModel] ()
    @Published var errorMessage: String?
    private let service = CoinDataService()
    
    init() {
        //fetchPrice(coin: "bitcoin")
        fetchCoins()
    }
    
    func fetchCoins() {
        //        service.fetchCoins { coins, error in
        //            DispatchQueue.main.async {
        //                if let error = error {
        //                    self.errorMessage = error.localizedDescription
        //                }
        //                self.coins = coins ?? []
        //            }
        //        }
        service.fetchCoinsWithResult { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


