//
//  HomeNavigationViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UINavigationController {

    static func instantiate() -> HomeNavigationViewController {
         return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationViewController") as! HomeNavigationViewController
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
