//
//  TableViewCell.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!

    var table: Table? {
        didSet {
            guard let table = table else { return }
            
            lbTableName.text = table.name
            activeSwitch.setOn(table.active, animated: false)
            
            updateLabelTableName()
            
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
        return "TableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 44.0
    }
    
    @IBAction func actionTapButtonDeleteTable(_ sender: UISwitch) {
        guard let table = self.table else { return  }
        
        if sender.isOn != table.active {
            let realm = try! Realm()
            try! realm.write {
                table.active = sender.isOn
            }
            updateLabelTableName()
        }
    }
    
    func updateLabelTableName() {
        guard let table = self.table else { return }
        
        lbTableName.textColor = table.active ? .black : .lightGray
    }

}
