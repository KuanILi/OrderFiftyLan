//
//  DrinksMenuTableViewCell.swift
//  OrderFiftyLan
//
//  Created by kuani on 2022/10/7.
//

import UIKit

class DrinksMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var drinksPicture: UIImageView!
    @IBOutlet weak var chineseName: UILabel!
    @IBOutlet weak var englishName: UILabel!
    @IBOutlet weak var midPrice: UILabel!
    @IBOutlet weak var larPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
