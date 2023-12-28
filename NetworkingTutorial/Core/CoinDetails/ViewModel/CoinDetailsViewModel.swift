//
//  CoinDetailsViewModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 27/12/23.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    @Published var coinDetails: CoinDetailsModel?
    
    init(coinId: String) {
        self.coinId = coinId
        
        Task { await fetchCoinDetails() }
        
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            let details = try await service.fetchCoinDetails(id: coinId)
            print("Debug: Detais \(details)")
            self.coinDetails = details
        } catch {
            print("Debug: Error \(error.localizedDescription)")
        }
    }
}
