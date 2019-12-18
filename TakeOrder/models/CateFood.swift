//
//  CateFood.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import Foundation
import RealmSwift

class CateFood: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    required init() {
    }
    
    init(name: String) {
        super.init()
        
        self.id = incrementID()
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        if let next = realm.objects(CateFood.self).sorted(byKeyPath: "id").last?.id {
            return next + 1
        }else{
            return 1
        }
    }
    
    class func getCateFoods() -> Results<CateFood> {
           let realm = try! Realm()
           let cates = { realm.objects(CateFood.self) }()
           return cates
       }
}
