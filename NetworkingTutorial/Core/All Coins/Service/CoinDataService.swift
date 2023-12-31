//
//  CoinDataService.swift
//  NetworkingTutorial
//
//  Created by Auto on 25/12/23.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchCoins() async throws -> [CoinModel]
    func fetchCoinDetails(id: String) async throws -> CoinDetailsModel?
}

class CoinDataService: CoinServiceProtocol, HTTPDataDownloader {
    
    private var page = 0
    private let fetchLimit = 30
    
    //Mark: Async/ Await
    
    func fetchCoins() async throws -> [CoinModel] {
        page += 1

        guard let endpoint = allCoinsURLString else {
            throw CoinAPIError.requestFailed(description: "Invalid API")
        }
        return try await fetchData(as: [CoinModel].self, endpoint: endpoint)
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetailsModel? {
        if let cached = CoinDetailsCache.shared.get(for: id) {
            print("DEBUG: Got details from cache")
            return cached
        }
        
        guard let endpoint = coinDetailsURLString(id: id) else {
            throw CoinAPIError.requestFailed(description: "Invalid API")
        }
        
        let details = try await fetchData(as: CoinDetailsModel.self, endpoint: endpoint)
        print("DEBUG: Got details from API")
        CoinDetailsCache.shared.set(details, forKey: id)
        
        return details
    }
    
    //Mark:   URL Components Refactor
    
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
        
        return components
    }
    
    private var allCoinsURLString: String? {
        var components = baseUrlComponents
        components.path += "markets"
        
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "\(fetchLimit)"),
            .init(name: "page", value: "\(page)"),
            .init(name: "price_change_percentage", value: "24h")
        ]
        
        return components.url?.absoluteString
    }
    
    private func coinDetailsURLString(id: String) -> String? {
        var components = baseUrlComponents
        components.path += "\(id)"
        
        components.queryItems = [
            .init(name: "localization", value: "false")
        ]
        
        return components.url?.absoluteString
    }
}

// Mark: Complesion Handler

extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[CoinModel], CoinAPIError>) -> Void) {
        guard let url = URL(string: allCoinsURLString ?? "") else { return }
        
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
