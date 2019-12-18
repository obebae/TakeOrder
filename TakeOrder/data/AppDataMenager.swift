//
//  AppDataMenager.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 17/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import Foundation
import RealmSwift


class AppDataMenager {
    static let shared = AppDataMenager()
    
    
    func setup() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "setup") {
            let result = moveFileToDocument()
            defaults.set(result, forKey: "setup")
        }
    }
    
    func moveFileToDocument() -> Bool {
        let bundlePath = Bundle.main.path(forResource: "default", ofType: ".realm")
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("default.realm")
        let fullDestPathString = fullDestPath!.path
        
        var result = false
        do{
            try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
            result = true
        }catch{
            print("\n")
            print(error)
        }
        
        return result
    }
}
