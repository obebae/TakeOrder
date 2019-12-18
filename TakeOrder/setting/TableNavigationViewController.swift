//
//  TableNavigationViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

class TableNavigationViewController: UINavigationController {

    static func instantiate() -> TableNavigationViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableNavigationViewController") as! TableNavigationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
