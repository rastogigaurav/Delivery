//
//  DeliveryItemTableViewCell.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/24/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit
import SDWebImage

class DeliveryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryItemImageView: UIImageView!
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var deliveryLocationLbl: UILabel!
    
    func configure(with delivery:Delivery){
        self.mainTitleLbl.text = delivery.description + " at"
        self.deliveryLocationLbl.text = delivery.location.address
        
        if let imageUrl = delivery.imageUrl{
            deliveryItemImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "deliveryIcon"))
        }
    }

}
