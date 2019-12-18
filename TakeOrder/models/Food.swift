//
//  Food.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import Foundation
import RealmSwift

class Food: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var cate: CateFood!
    
    required init() {
    }
    
    
    init(name: String, cate: CateFood) {
        super.init()
        
        self.id = incrementID()
        self.name = name
        self.cate = cate
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        if let next = realm.objects(Food.self).sorted(byKeyPath: "id").last?.id {
            return next + 1
        }else{
            return 1
        }
    }
    
    class func getFoodsByCate(_ cateID: String = "") -> Results<Food> {
        let realm = try! Realm()
        var foods = { realm.objects(Food.self) }()
        if cateID != "" {
            foods = foods.filter("cate.id == \(cateID)")
        }
        return foods
    }
}
