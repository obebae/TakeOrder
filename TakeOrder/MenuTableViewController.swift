//
//  MenuTableViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit

struct Menu {
    var title: String
    var viewController: UIViewController
}

class MenuTableViewController: UITableViewController {
    
    let menus = [Menu(title: "หน้าหลัก", viewController: HomeNavigationViewController.instantiate()),
                 Menu(title: "จัดการโต๊ะ", viewController: TableNavigationViewController.instantiate()),
                 Menu(title: "จัดการอาหาร", viewController: CateNavigationViewController.instantiate())]
    
    static func instantiate() -> MenuTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Menu"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row].title
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let slideMenu = self.slideMenuController() else { return }
        
        let row = indexPath.row
        let viewController = menus[row].viewController
        slideMenu.changeMainViewController(viewController, close: true)
        
        
    }
}
