//
//  OrderTableViewCell.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNo: UILabel!
    @IBOutlet weak var lbFood: UILabel!
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var lbAmount: UILabel!
    
    var food: FoodBill? {
        didSet {
            guard let food = food else { return }
            
            lbFood.text = food.food_name
            lbAmount.text = "\(food.amount)"
            
            btnDecrease.isEnabled = (food.amount == 1) ? false : true
            
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
        return "OrderTableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 44.0
    }
    
    @IBAction func actionTapButtonDecrease(_ sender: Any) {
        guard let food = food else { return }
        
        food.amount-=1
        if food.amount == 1 {
            btnDecrease.isEnabled = false
        }
        updateAmount(food: food)
    }
    
    @IBAction func actionTapButtonIncrease(_ sender: Any) {
        guard let food = food else { return }
        
        food.amount+=1
        if food.amount > 1 {
            btnDecrease.isEnabled = true
        }
        updateAmount(food: food)
    }
    
    func updateAmount(food: FoodBill){
        guard let foodRef = food.ref else { return }
        foodRef.updateChildValues([
            "amount" : food.amount
        ])
    }
}
