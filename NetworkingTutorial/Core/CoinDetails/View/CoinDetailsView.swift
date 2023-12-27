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
    
    init(coin: CoinModel) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(coin.name)
                Text(": $\(coin.currentPrice)")
            }
            //Text(coin.description)
        }
    }
}

//#Preview {
//    CoinDetailsView()
//}
