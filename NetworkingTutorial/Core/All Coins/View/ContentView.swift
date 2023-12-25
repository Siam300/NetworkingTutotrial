//
//  ContentView.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    
    
    var body: some View {
        List {
            ForEach(viewModel.coins) { coin in
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
        .overlay {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
