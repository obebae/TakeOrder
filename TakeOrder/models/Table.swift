//
//  Table.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import Foundation
import RealmSwift

class Table: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var status = "empty"
    @objc dynamic var active = true
    
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
        if let next = realm.objects(Table.self).sorted(byKeyPath: "id").last?.id {
            return next + 1
        }else{
            return 1
        }
    }
    
    class func getTables(filter: String = "") -> Results<Table> {
        let realm = try! Realm()
        let tables = { realm.objects(Table.self) }()
        if filter == "" {
            return tables
        }else{
            return tables.filter(filter)
        }
    }
}
