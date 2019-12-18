//
//  SelectFoodViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import ActionSheetPicker_3_0

class SelectFoodViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnSelectCate: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectFood: FoodBill!
    var selectCate: CateFood!
    
    
    let realm = try! Realm()
    //    var foods: Results<Food> =
    lazy var cates = CateFood.getCateFoods()
    lazy var foods = Food.getFoodsByCate()
    var foodInCates: Results<Food>!
    
    
    static func instantiate() -> SelectFoodViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectFoodViewController") as! SelectFoodViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        selectCate = cates.first
        setTitleButtonSelectCate()
        
        foodInCates = foods.filter("cate.id == \(selectCate.id)")
    }
    
    
    func setTitleButtonSelectCate() {
        guard let cate = selectCate else { return }
        btnSelectCate.setTitle(cate.name, for: .normal)
    }
    
    @IBAction func actionTapButtonSelectCate(_ sender: UIButton) {
        var titles: [String] = []
        for t in cates {
            titles.append(t.name)
        }
        guard let indexSelect = cates.index(of: selectCate) else { return }
        
        ActionSheetStringPicker.show(withTitle: "เลือกหมวดหมู่อาหาร",
                                     rows: titles,
                                     initialSelection: indexSelect,
                                     doneBlock: { picker, value, index in
                                        self.selectCate = self.cates[value]
                                        self.setTitleButtonSelectCate()
                                        
                                        guard let cate = self.selectCate else { return }
                                        self.foodInCates = self.foods.filter("cate.id == \(cate.id)")
                                        self.tableView.reloadData()
                                        return
        },
                                     cancel: { picker in
                                        return
        },
                                     origin: sender)
    }
    
    @IBAction func actionTapCloseSelectFoodView(_ sender: UIBarButtonItem) {
        
    }
    
}

extension SelectFoodViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInCates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectFoodTableViewCell.getCellIdentifier(), for: indexPath) as! SelectFoodTableViewCell
        
        let food = foodInCates[indexPath.row]
        cell.food = food
        
        return cell
    }
    
}

extension SelectFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectFoodTableViewCell
        let food = cell.food
        
        guard let f = food else { return }
        confirmSelectFood(food: f)
    }
    
    func confirmSelectFood(food: Food) {
        let alertAddFoodView = UIAlertController(title: "เพิ่มรายการอาหาร", message: nil, preferredStyle: .alert)
        let btnConfirm = UIAlertAction(title: "เพิ่ม", style: .default) { (action) in
            if let textField = alertAddFoodView.textFields?.first,
                let text = textField.text,
                text != ""{
                
                guard let amount = Int(text) else {
                    self.view.makeToast("จำนวนไม่ถูกต้อง")
                    return
                }
                self.selectFood = FoodBill(key: food.id, food: food.name, amount: amount)
                self.performSegue(withIdentifier: "unwindSelectFood", sender: self)
                
            }else{
                self.view.makeToast("พบค่าว่าง")
            }
        }
        let btnCancle = UIAlertAction(title: "ยกเลิก", style: .cancel) { (action) in
            
        }
        alertAddFoodView.addTextField { (textField) in
            textField.placeholder = ""
            textField.becomeFirstResponder()
            textField.keyboardType = .numberPad
            textField.text = "1"
        }
        alertAddFoodView.addAction(btnCancle)
        alertAddFoodView.addAction(btnConfirm)
        
        self.present(alertAddFoodView, animated: true, completion: nil)
    }
}

extension OrderViewController {
    @IBAction func actionTapCloseSelectFoodView(_ segue: UIStoryboardSegue) {
        guard let selectFoodViewControler = segue.source as? SelectFoodViewController,
            let food = selectFoodViewControler.selectFood else {
                print("error return")
                return
        }
        
        let keys = FoodBill.getAllKeys(foodBills)
        if let index = keys.firstIndex(of: food.key){
            let foodOld = foodBills[index]
            foodOld.amount = foodOld.amount + food.amount
            
            guard let foodRef = foodOld.ref else { return }
            foodRef.updateChildValues([
                "amount" : foodOld.amount
            ])
        }else{
            let foodRef = self.dbRef.child("\(food.key)")
            foodRef.setValue(food.toAnyObject())
        }
    }
}
