//
//  Delivery.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

struct Delivery : Decodable{
    var id:Int
    var description:String
    var imageUrl:String?
    var location:Location
}

struct Location : Decodable {
    var lat: Double
    var lng: Double
    var address: String
}
