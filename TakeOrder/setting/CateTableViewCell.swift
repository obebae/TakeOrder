//
//  CateTableViewCell.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift

class CateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbCateName: UILabel!

    var cate: CateFood? {
        didSet {
            guard let cate = cate else { return }
            lbCateName.text = cate.name
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
        return "CateTableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 44.0
    }
    
}
