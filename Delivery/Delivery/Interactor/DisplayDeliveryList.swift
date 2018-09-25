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
    func fetchDeliveries(completionHandler:@escaping ([DeliveryItem]?)->Void) ->Void
}

struct DisplayDeliveryList {
    
    var repository : DeliveryListRepositoryProtocol
    
    init(with repository:DeliveryListRepositoryProtocol) {
        self.repository = repository
    }
}

extension DisplayDeliveryList : DisplayDeliveryListProtocol{
    func fetchDeliveries(completionHandler: @escaping ([DeliveryItem]?) -> Void) {
        self.repository.getDeliveries(with: 0, and: 10) {
            completionHandler(.none)
        }
    }
}
