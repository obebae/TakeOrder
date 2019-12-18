//
//  SelectFoodTableViewCell.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 17/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

class SelectFoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbFoodName: UILabel!
    @IBOutlet weak var lbFoodCate: UILabel!
    
    var food: Food? {
        didSet {
            guard let food = food else { return }
            
            lbFoodName.text = food.name
            lbFoodCate.text = food.cate.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func getCellIdentifier() -> String{
        return "SelectFoodTableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 44.0
    }
}
