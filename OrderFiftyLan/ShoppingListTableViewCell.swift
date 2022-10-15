//
//  ShoppingListTableViewCell.swift
//  OrderFiftyLan
//
//  Created by kuani on 2022/10/7.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinksPic: UIImageView!
    @IBOutlet weak var drinksName: UILabel!
    @IBOutlet weak var drinksSize: UILabel!
    @IBOutlet weak var drinksSugar: UILabel!
    @IBOutlet weak var drinksIce: UILabel!
    @IBOutlet weak var drinksPrice: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
