//
//  CoinsViewModelTest.swift
//  NetworkingTutorialTests
//
//  Created by Auto on 31/12/23.
//

import Foundation
@testable import NetworkingTutorial
import XCTest


class CoinsViewModelTest: XCTestCase {
    
    func testInit() {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        XCTAssertNotNil(viewModel, "The viewModel should not be nil")
    }
    
    func testSuccessfulCoinFetch() async {
        let service = MockCoinService()
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        XCTAssertTrue(viewModel.coins.count > 0) //ensures that all coins array has coins
        XCTAssertEqual(viewModel.coins.count, 20) //ensures that all coins were decoded
        
        XCTAssertEqual(viewModel.coins, viewModel.coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })) //ensures sorting order
    }
    
    func testCoinFetchWithInvalidJson() async {
        let service = MockCoinService()
        service.mockData = mockCoinsData_invalidJson
        
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        
        XCTAssertTrue(viewModel.coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testThrowsInvalidDataError() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidData
        
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidData.customDescription)
    }
    
    func testThrowsInvalidStatusCode() async {
        let service = MockCoinService()
        service.mockError = CoinAPIError.invalidStatusCode(description: 404)
        
        let viewModel = CoinsViewModel(service: service)
        
        await viewModel.fetchCoins()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, CoinAPIError.invalidStatusCode(description: 404).customDescription)
    }
}
