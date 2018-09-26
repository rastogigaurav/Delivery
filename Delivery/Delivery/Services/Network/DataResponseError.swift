//
//  DataResponseError.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case none
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data".localizedString
        case .decoding:
            return "An error occurred while decoding data".localizedString
        case .none:
            return "None".localizedString
        }
    }
}
