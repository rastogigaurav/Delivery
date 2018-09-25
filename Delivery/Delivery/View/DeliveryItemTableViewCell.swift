//
//  DeliveryItemTableViewCell.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/24/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class DeliveryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryItemImageView: UIImageView!
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var deliveryLocationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with  deliveryItem:DeliveryItem?){
        if let dItem = deliveryItem{
            //self.deliveryLocationLbl.text = dItem.location.address
        }
        else{
            
        }
    }

}
