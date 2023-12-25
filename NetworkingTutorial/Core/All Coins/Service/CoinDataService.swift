//
//  CoinDataService.swift
//  NetworkingTutorial
//
//  Created by Auto on 25/12/23.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en"
    
    func fetchCoins(completion: @escaping([CoinModel]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let coins = try? JSONDecoder().decode([CoinModel].self, from: data) else {
                print("Debug: Failed to decode coins")
                return
            }
            
            completion(coins)
            
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Debug: Faild with error \(error.localizedDescription)")
                //                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                //                self.errorMessage = "Bad HTTP response"
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                //                self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to purse value")
                return
            }
            guard let price = value["usd"] else { return }
            
            completion(price)
        }.resume()
    }
}
