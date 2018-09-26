//
//  DeliveryListViewModel.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

protocol DeliveryItemViewModelProtocol {
    
    /// Method used to notify view has been loaded and further it is initiating the list fetch
    mutating func didLoad()
    
    /// Method used to return number of rows to be displayed in All Deliveries Table
    ///
    /// - Returns: Count of number of items [Deliveriry]
    func numberOfRows()->Int
    
    /// Method used to return Delivery instance at parametric index
    ///
    /// - Parameter index: Index to pick out Delivery Item at
    /// - Returns: An instance of Delivery
    func delivery(at index:Int)->Delivery
    
    func fetchData(offset: Int, limit: Int, shouldAppend: Bool)->Void
}

class DeliveryListViewModel {
    
    /// An Integger variable used to track the index of last fetched DeliveryItem
    var currentlastFetchedIndex = 0
    
    /// An Array used to store all delivery items fetched
    var items : [Delivery] = []
    
    /// An private instance of DisplayDeliveryListProtocol <Interactor>
    private var interactor : DisplayDeliveryListProtocol
    
    /// A Closure used to notify View/Controller to re-render/reload UI
    var reload : ((_ success: Bool, _ dataCount: Int)->Void) = { _,_ in }
    
    /// A String variable used to retrieve View/Controller title
    var title = {
        return "Things to Deliver"
    }
    
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
        let interactor:DisplayDeliveryList = DisplayDeliveryList()
        return DeliveryListViewModel(with: interactor)
    }
    
    func didLoad(){
        fetchData(offset: 0, limit: limit, shouldAppend: false)
    }
    
    func numberOfRows()-> Int{
        return self.items.count
    }
    
    func delivery(at index: Int) -> Delivery {
        return self.items[index]
    }
    
    func fetchData(offset: Int, limit: Int, shouldAppend: Bool) {
        self.interactor.fetch(deliveries: offset, and: limit) { (result) in
            switch result {
            case .success(let itemsFetched):
                self.items += itemsFetched
                self.reload(true, itemsFetched.count)
                break
            case .failure:
                self.reload(false, 0)
                break
            }
        }
    }
}
