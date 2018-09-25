//
//  Constants.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//



enum InternetProtocol : String {
    case http = "http://"
    case https = "https://"
}

let hostname = "mock-api-mobile.dev.lalamove.com"

enum Endpoint : String {
    case deliveries = "/deliveries"
    case details = "/details"
}

struct K {
    struct ProductionServer {
        static let baseURL = InternetProtocol.https.rawValue + "mock-api-mobile.dev.lalamove.com"
    }
    
    struct APIParameterKey {
        static let offset = "offset"
        static let limit = "limit"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

