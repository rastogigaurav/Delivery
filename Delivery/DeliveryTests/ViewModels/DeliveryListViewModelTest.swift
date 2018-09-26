//
//  DeliveryListViewModelTest.swift
//  DeliveryTests
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import Delivery

class DeliveryListViewModelTest: XCTestCase {
    
    let interactor = DisplayDeliveryListMock()
    var viewModel:DeliveryListViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = DeliveryListViewModel(with:interactor)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        viewModel = nil
    }
    
    func testFetchData() {
        let expectation = self.expectation(description: "Expected to call APIClient methods while fetching data")
        self.viewModel.reload = { (succes,dataCount) in
            XCTAssertFalse(succes)
            XCTAssertEqual(dataCount, 0)
            expectation.fulfill()
        }
        self.viewModel.didLoad()
        
        waitForExpectations(timeout: 2.0) { (error) in
            if let _ = error {
                XCTFail("Failed to fetch data")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
