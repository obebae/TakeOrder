//
//  OrderViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class OrderViewController: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var btnCloseTable: UIButton!
    
    var table: Table!
    var foodBills: [FoodBill] = []
    var billKey = "0"
    
    var dbRef = Database.database().reference()
    
    static func instantiate() -> OrderViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeToastActivity(.center)
        
        
        guard let table = table else { return }
        title = "รายการของ \(table.name)"
        billKey = "\(table.id)"
        
        dbRef = dbRef.child(billKey)
        dbRef.observe(.value, with: { snapshot in
            var newItems: [FoodBill] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let bill = FoodBill(snapshot: snapshot) {
                    newItems.append(bill)
                }
            }
            self.foodBills = newItems
            self.orderTableView.reloadData()
            
            self.btnCloseTable.isEnabled = (self.foodBills.count == 0) ? false : true
            
            self.view.hideToastActivity()
        })
    }
    
    
    @IBAction func actionTapButtonCloseBill(_ sender: UIButton) {
        let alertAddTableView = UIAlertController(title: "ปิดโต๊ะ", message: nil, preferredStyle: .alert)
        let btnConfirm = UIAlertAction(title: "ยืนยัน", style: .default) { (action) in
            self.dbRef.removeValue()
            self.navigationController?.popViewController(animated: true)
        }
        let btnCancle = UIAlertAction(title: "ยกเลิก", style: .cancel)
        alertAddTableView.addAction(btnCancle)
        alertAddTableView.addAction(btnConfirm)
        
        self.present(alertAddTableView, animated: true, completion: nil)
    }
    
}

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodBills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.getCellIdentifier(), for: indexPath) as! OrderTableViewCell
        cell.selectionStyle = .none
        
        let index = indexPath.row
        cell.lbNo.text = "\(index + 1)"
        
        let food = foodBills[index]
        cell.food = food
        
        return cell
        
    }
}

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let food = foodBills[indexPath.row]
            
            guard let foodRef = food.ref else { return }
            foodRef.removeValue()
        }
    }
}
