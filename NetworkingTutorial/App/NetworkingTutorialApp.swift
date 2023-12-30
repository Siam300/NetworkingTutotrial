//
//  NetworkingTutorialApp.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import SwiftUI

@main
struct NetworkingTutorialApp: App {
//    @StateObject var viewModel = CoinsViewModel(service: CoinDataService())  //alternate
    
    var body: some Scene {
        WindowGroup {
            ContentView(service: CoinDataService())
//            ContentView()
//                .environmentObject(viewModel) //alternate
        }
    }
}
