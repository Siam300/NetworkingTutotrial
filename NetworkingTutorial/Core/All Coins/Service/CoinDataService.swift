//
//  CoinDataService.swift
//  NetworkingTutorial
//
//  Created by Auto on 25/12/23.
//

import Foundation

class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en"
    
    //Mark: Async/ Await
    
    func fetchCoins() async throws -> [CoinModel] {
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let coins = try JSONDecoder().decode([CoinModel].self, from: data)
            return coins
        } catch {
            print("Debug: Error \(error.localizedDescription)")
            return []
        }
    }
}

// Mark: Complesion Handler

extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[CoinModel], CoinAPIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(description: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([CoinModel].self, from: data)
                completion(.success(coins))
            } catch {
                print("Debug: Failed to decode with error: \(error)")
                completion(.failure(.jsonParsingFaliure))
            }
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
