//
//  CoinDetailsView.swift
//  NetworkingTutorial
//
//  Created by Auto on 27/12/23.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: CoinModel
    @ObservedObject var viewModel: CoinDetailsViewModel
    //@State private var task: Task<(), Never>? //to cancel unneccesary api calls using .onappear
    
    init(coin: CoinModel) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id)
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
        
        //best method to prevent unneccesary api calls
        .task {
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
