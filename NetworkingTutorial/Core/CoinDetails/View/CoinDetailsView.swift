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
        if let details = viewModel.coinDetails {
            VStack(alignment: .leading) {
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
            .padding()
        }
    }
}

//#Preview {
//    CoinDetailsView()
//}
