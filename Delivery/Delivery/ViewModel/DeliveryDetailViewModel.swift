//
//  DeliveryDetailViewModel.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/26/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation
import MapKit

protocol DeliveryDetailViewModelProtocol {
    /// Method used to notify view has been loaded
    mutating func didLoad()
    
    /// Method used to retrieve the description string from DeliveryItem instance
    ///
    /// - Returns: Description String
    func deliveryDescriptionStrig()->String
    
    /// Method used to retrieve the Address string from DeliveryItem.Location instance
    ///
    /// - Returns: Address String
    func deliveryAddressString()->String
    
    /// Method used to retrieve the image url string from DeliveryItem instance
    ///
    /// - Returns: Image Url String
    func deliveryImageUrl()->String
    
    
    /// Method used to retrieve CLLocationCoordinate2D from DeliveryItem.Location (lat, lng)
    ///
    /// - Returns: An instance of CLLocationCoordinate2D
    func deliveryLocationCoordinates() -> CLLocationCoordinate2D
}

struct DeliveryDetailViewModel {
    
    /// An instance of Delivery used for various UI Login/Representation on View/Controller
    var delivery:Delivery!
    
    /// An instance of closure used to notify controller to reload/re-render UI
    var reload = {}
    
    /// A String variable used to retrieve View/Controller title
    var title = {
        return "Delivery Details"
    }
}

extension DeliveryDetailViewModel : DeliveryDetailViewModelProtocol {
    func didLoad() {
        self.reload()
    }
    
    func deliveryAddressString()->String{
        return delivery.location.address
    }
    
    func deliveryDescriptionStrig()->String {
        return delivery.description + " at"
    }
    
    func deliveryImageUrl() -> String {
        return delivery.imageUrl ?? ""
    }
    
    func deliveryLocationCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude:delivery.location.lat , longitude:delivery.location.lng )
    }
    
}
