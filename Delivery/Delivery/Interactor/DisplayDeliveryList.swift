//
//  DisplayDeliveryList.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DisplayDeliveryListProtocol {
    
    /// Methods used to fetch list of items to be delivered
    ///
    /// - Parameter completionHandler: handler used to return items list on completion
    mutating func fetch(deliveries offset: Int, and limit: Int, completion: @escaping (Result<[Delivery],DataResponseError>) -> Void) ->Void
}

struct DisplayDeliveryList : DisplayDeliveryListProtocol{
    func fetch(deliveries offset: Int, and limit: Int, completion: @escaping (Result<[Delivery],DataResponseError>) -> Void) {
        APIClient.get(deliveriesWith: offset, limit: limit) { result in
            completion(result)
        }
    }
}
