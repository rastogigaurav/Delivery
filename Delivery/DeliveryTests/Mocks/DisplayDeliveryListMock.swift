//
//  DisplayDeliveryListMock.swift
//  DeliveryTests
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation
@testable import Delivery

struct DisplayDeliveryListMock : DisplayDeliveryListProtocol {
    var fetchDeliveriesGetsCalled = false
    
    mutating func fetch(deliveries offset: Int, and limit: Int, completion: @escaping (Result<[Delivery], DataResponseError>) -> Void) {
        fetchDeliveriesGetsCalled = true
        completion(.failure(.none))
    }
}
