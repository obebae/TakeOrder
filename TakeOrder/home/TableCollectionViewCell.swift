//
//  TableCollectionViewCell.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    
    var table: Table? {
        didSet {
            guard let table = table else { return }
            
            lbName.text = table.name
        }
    }
    
    func setBorder(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8.0
    }
    
    class func getCellIdentifier() -> String{
        return "TableCollectionViewCell"
    }
    
    class func itemsPerRow() -> CGFloat {
        return 3.0
    }
    
    class func getSectionInsets() -> UIEdgeInsets{
        return UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    }
}
