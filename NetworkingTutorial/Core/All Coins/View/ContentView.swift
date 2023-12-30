//
//  ContentView.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var viewModel: CoinsViewModel //alternate
    
    private let service: CoinDataService
    @StateObject var viewModel: CoinsViewModel
    
    init(service: CoinDataService) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: CoinsViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundColor(.gray)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.bold)
                                
                                Text(coin.symbol)
                                
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
//            .navigationDestination(for: CoinModel.self, destination: { coin in
//                CoinDetailsView(coin: coin) 
//            }) //alternate
            
            .navigationDestination(for: CoinModel.self, destination: { coin in
                CoinDetailsView(coin: coin, service: service)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: CoinDataService())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//} //alternate
