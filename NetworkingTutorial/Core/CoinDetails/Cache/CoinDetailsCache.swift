//
//  CoinDetailsCache.swift
//  NetworkingTutorial
//
//  Created by Auto on 30/12/23.
//

import Foundation

class CoinDetailsCache {
    static let shared = CoinDetailsCache()
    private let cache = NSCache<NSString, NSData>()
    
    private init() { }
    
    func set(_ coinDetails: CoinDetailsModel, forKey key: String) {
        guard let data = try? JSONEncoder().encode(coinDetails) else { return }
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(for key: String) -> CoinDetailsModel? {
        guard let data = cache.object(forKey: key as NSString) as? Data else { return nil }
        return try? JSONDecoder().decode(CoinDetailsModel.self, from: data)
    }
}
