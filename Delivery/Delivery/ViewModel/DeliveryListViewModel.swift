//
//  DeliveryListViewModel.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class DeliveryListViewModel: NSObject {
    var interactor : DisplayDeliveryListProtocol
    /// Custom initialization methods used to inject dependencies and thus instantiate DeliveryListViewModel
    ///
    /// - Parameter interactor: An instance of DisplayDeliveryList (Interactor) , getting passed as a dependancy
    init(with interactor:DisplayDeliveryListProtocol) {
        self.interactor = interactor
    }
    
    func numberOfRows(){
        
    }
}

extension DeliveryListViewModel {
    
    /// Static method used to inject the dependencies and thus create DeliveryListViewModel
    ///
    /// - Returns: An instance of DeliveryListViewModel
    static func create()->DeliveryListViewModel {
        let interactor:DisplayDeliveryList = DisplayDeliveryList()
        return DeliveryListViewModel(with: interactor)
    }
}
