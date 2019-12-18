//
//  FoodBill.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 17/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import Foundation
import Firebase

class FoodBill {
    let ref: DatabaseReference?
    let key: Int
    let food_name: String
    var amount: Int
    
    init(key: Int, food: String, amount: Int) {
        self.ref = nil
        self.key = key
        self.food_name = food
        self.amount = amount
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
        let key = value["key"] as? Int,
        let food = value["food_name"] as? String,
        let amount = value["amount"] as? Int else { return nil }
        
        self.ref = snapshot.ref
        self.key = key
        self.food_name = food
        self.amount = amount
    }
    
    func toAnyObject() -> Any {
      return [
        "key": key,
        "food_name": food_name,
        "amount": amount
      ]
    }
    
    class func getAllKeys(_ arr: [FoodBill]) -> [Int] {
        var keys: [Int] = []
        for k in arr {
            keys.append(k.key)
        }
        
        return keys
    }
}

