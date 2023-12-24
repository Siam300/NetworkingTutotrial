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
        VStack {
            VStack {
                Text("\(viewModel.coin): \(viewModel.price)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
