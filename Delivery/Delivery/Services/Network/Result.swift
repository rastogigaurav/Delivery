//
//  Result.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
