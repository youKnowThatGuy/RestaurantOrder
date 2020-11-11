//
//  OrderCell.swift
//  RestaurantOrder
//
//  Created by Клим on 21.10.2020.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var OrderTitle: UILabel!
    
    @IBOutlet weak var ClientName: UILabel!
    
    @IBOutlet weak var billLabel: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    static let identifier = "OrderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
