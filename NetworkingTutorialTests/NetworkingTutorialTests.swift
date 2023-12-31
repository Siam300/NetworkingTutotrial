//
//  NetworkingTutorialTests.swift
//  NetworkingTutorialTests
//
//  Created by Auto on 31/12/23.
//

import XCTest
@testable import NetworkingTutorial

final class NetworkingTutorialTests: XCTestCase {

    func test_DecodeCoinsIntoArray_marketCapDesc() throws {
        do {
            let coins = try JSONDecoder().decode([CoinModel].self, from: mockCoinsData_marketCapDesc)
            XCTAssertTrue(coins.count > 0) //ensures that all coins array has coins
            XCTAssertEqual(coins.count, 20) //ensures that all coins were decoded
            
            XCTAssertEqual(coins, coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) //ensures sorting order
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
