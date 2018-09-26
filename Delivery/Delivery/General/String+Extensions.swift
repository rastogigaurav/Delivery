//
//  String+Extensions.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/27/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}

