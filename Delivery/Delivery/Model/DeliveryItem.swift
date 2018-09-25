//
//  DeliveryItem.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

struct DeliveryItem : Codable{
    var id:Int
    var description:String?
    var imageUrl:String?
    var location:Location
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case description = "description"
        case imageUrl = "imageUrl"
        case lat = "lat"
        case lng = "lng"
        case address = "address"
    }
}

struct Location : Codable {
    var lat: Double?
    var lng: Double?
    var address: String?
}

extension DeliveryItem {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        description = try values.decode(String.self, forKey: .description)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        let lat = try values.decode(Double.self, forKey: .lat)
        let lng = try values.decode(Double.self, forKey: .lng)
        let address = try values.decode(String.self, forKey: .address)
        location = Location(lat: lat, lng: lng, address: address)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(location.lat, forKey: .lat)
        try container.encode(location.lng, forKey: .lng)
        try container.encode(location.address, forKey: .address)
    }
}

