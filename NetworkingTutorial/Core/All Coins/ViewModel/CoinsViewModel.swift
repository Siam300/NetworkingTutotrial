//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Auto on 12/10/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    
    init() {
        fetchPrice(coin: "bitcoin", price: "bdt")
    }
    
    func fetchPrice(coin: String, price: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=\(price)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                
                guard let value = jsonObject[coin] as? [String: Double] else { return }
                guard let price = value[price] else { return }
                
                DispatchQueue.main.async {
                    self.coin = coin.capitalized
                    self.price = "\(price) bdt"
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
}


