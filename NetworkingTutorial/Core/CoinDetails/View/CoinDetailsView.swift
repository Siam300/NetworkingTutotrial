//
//  CoinDetailsView.swift
//  NetworkingTutorial
//
//  Created by Auto on 27/12/23.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: CoinModel
    
//    @EnvironmentObject var viewModel: CoinsViewModel //alternate
//    
//    init(coin: CoinModel) {
//        self.coin = coin
//    } //alternate
    
    @State private var task: Task<(), Never>? //to cancel unneccesary api calls using .onappear
    
    @ObservedObject var viewModel: CoinDetailsViewModel
    
    init(coin: CoinModel, service: CoinServiceProtocol) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id, service: service)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                Text(details.name)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(details.symbol.uppercased())
                    .font(.footnote)
                ScrollView {
                    Text(details.description.text)
                        .padding(.vertical)
                }
            }
        }
        .padding()
        
        //best method to prevent unneccesary api calls code is more cleanner
        .task {
//            await viewModel.fetchCoinDetails(coinId: coin.id) //alternate
            await viewModel.fetchCoinDetails()
        }
        //---------00---------//
//        To prevent api call 2 times use this .onapper method
//        .onAppear {
//            self.task = Task { await viewModel.fetchCoinDetails() }
//        }
//        api call cancellation
//        .onDisappear {
//            task?.cancel()
//        }
        //---------00---------//
    }
}

//#Preview {
//    CoinDetailsView()
//}
