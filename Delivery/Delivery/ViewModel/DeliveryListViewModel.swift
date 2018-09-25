//
//  DeliveryListViewModel.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DeliveryItemViewModelProtocol {
    
    /// Method used to notify view has been loaded and further it initiating the list fetch
    mutating func didLoad()
    
    /// Method used to return number of rows to be displayed in All Deliveries Table
    ///
    /// - Returns: Count of number of items [Deliveriry Items]
    func numberOfRows()->Int
    
    /// Method used to return DeliveryItem instance at parametric index
    ///
    /// - Parameter index: Index to pick out Delivery Item at
    /// - Returns: An instance of Delivery Item
    func deliveryItem(at index:Int)->DeliveryItem
}

struct DeliveryListViewModel {
    var items : [DeliveryItem] = []
    var interactor : DisplayDeliveryListProtocol
    
    /// Custom initialization methods used to inject dependencies and thus instantiate DeliveryListViewModel
    ///
    /// - Parameter interactor: An instance of DisplayDeliveryList (Interactor) , getting passed as a dependancy
    init(with interactor:DisplayDeliveryListProtocol) {
        self.interactor = interactor
    }
}

extension DeliveryListViewModel : DeliveryItemViewModelProtocol {
    
    /// Static method used to inject the dependencies and thus create DeliveryListViewModel
    ///
    /// - Returns: An instance of DeliveryListViewModel
    static func create()->DeliveryListViewModel {
        let repository:DeliveryListRepository = DeliveryListRepository()
        let interactor:DisplayDeliveryList = DisplayDeliveryList(with: repository)
        return DeliveryListViewModel(with: interactor)
    }
    
    mutating func didLoad(){
        self.interactor.fetchDeliveries { list in
            guard let itemsFetched = list else {
                print("No Items Found to be Delivered")
                return
            }
            //self.items = itemsFetched
        }
    }
    
    func numberOfRows()-> Int{
        return self.items.count
    }
    
    func deliveryItem(at index: Int) -> DeliveryItem {
        return self.items[index]
    }
}
