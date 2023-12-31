//
//  ContentView.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import SwiftUI

struct ContentView: View {
//    @EnvironmentObject var viewModel: CoinsViewModel //alternate
    
    private let service: CoinServiceProtocol
    @StateObject var viewModel: CoinsViewModel
    
    init(service: CoinServiceProtocol) {
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

                            AsyncImage(url: URL(string: coin.image)) { image in
                                image
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            } placeholder: {
                                EmptyView()
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.bold)
                                
                                Text(coin.symbol)
                                
                            }
                        }
                        .onAppear {
                            if coin == viewModel.coins.last {
                                Task { await viewModel.fetchCoins() }
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
        .task{
            await viewModel.fetchCoins()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: CoinServiceProtocol.self as! CoinServiceProtocol) //service: CoinServiceProtocol()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//} //alternate
