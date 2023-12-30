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
        //NOTE: For some reason this wasnt calling task modifire 2 times in new xcode if this happens then comment this TASK like and use .onapper methon in coinDetailsView
        //Task { await fetchCoinDetails() }
        
    }
    
    @MainActor
    func fetchCoinDetails() async {
        //if i need to use .onapper method to prevent api calls 2 times then i need to add delay also
//        print("DEBUG: fetching coins...")
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        print("DEBUG: task woke up...")
        
        do {
            self.coinDetails = try await service.fetchCoinDetails(id: coinId)
            //print("DEBUG: Detais \(details)")
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
