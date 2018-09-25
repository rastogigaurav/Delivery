//
//  DeliveryListRepository.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DeliveryListRepositoryProtocol {
    func getDeliveries(with offset:Int, and limit:Int, completion: @escaping()->Void)->Void
}

class DeliveryListRepository: NSObject, DeliveryListRepositoryProtocol {
    func getDeliveries(with offset: Int, and limit: Int, completion: @escaping () -> Void) {
        APIClient.getDeliveries(offset: offset, limit: limit) { (result) in
            
        }
    }
}
