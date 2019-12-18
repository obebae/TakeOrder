//
//  FoodInCateTableViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import Toast_Swift

class FoodInCateTableViewController: UITableViewController {
    
    var cate: CateFood!
    
    let realm = try! Realm()
    var foods: Results<Food>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if cate != nil {
            title = cate.name
            foods  = Food.getFoodsByCate("\(cate.id)")
        }
    }
    
    @IBAction func actionTapButtonAddFood(_ sender: UIBarButtonItem) {
        let alertAddFoodView = UIAlertController(title: "เพิ่มรายการอาหาร", message: nil, preferredStyle: .alert)
        let btnConfirm = UIAlertAction(title: "เพิ่ม", style: .default) { (action) in
            if let textField = alertAddFoodView.textFields?.first,
                let text = textField.text,
                text != ""{
                
                guard let cate = self.cate else { return }
                
                let food = Food(name: text, cate: cate)
                self.saveAddNewFood(food: food)
            }else{
                self.view.makeToast("พบค่าว่าง")
            }
        }
        let btnCancle = UIAlertAction(title: "ยกเลิก", style: .cancel) { (action) in
            
        }
        alertAddFoodView.addTextField { (textField) in
            textField.placeholder = ""
            textField.becomeFirstResponder()
        }
        alertAddFoodView.addAction(btnCancle)
        alertAddFoodView.addAction(btnConfirm)
        
        self.present(alertAddFoodView, animated: true, completion: nil)
    }
    
    func saveAddNewFood(food: Food) {
        try! realm.write {
            realm.add(food)
            self.view.makeToast("เพิ่มรายการ \(food.name) สำเร็จ")
            foods = Food.getFoodsByCate("\(cate.id)")
            self.tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .automatic)
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.getCellIdentifier(), for: indexPath) as! ListTableViewCell
        
        let food = foods[indexPath.row]
        cell.food = food
        
        return cell
    }
    
}
