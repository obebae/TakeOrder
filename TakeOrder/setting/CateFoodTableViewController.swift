//
//  CateFoodTableViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 16/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import Toast_Swift

class CateFoodTableViewController: UITableViewController {

    let realm = try! Realm()
    lazy var cates: Results<CateFood> = CateFood.getCateFoods()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func actionTapButtonMenu(_ sender: UIBarButtonItem) {
        guard let slideMenu = self.slideMenuController() else { return  }
        slideMenu.openLeft()
    }
    
    @IBAction func actionTapButtonAddCate(_ sender: UIBarButtonItem) {
        let alertAddCateView = UIAlertController(title: "เพิ่มรายการหมวดหมู่อาหาร", message: nil, preferredStyle: .alert)
        let btnConfirm = UIAlertAction(title: "เพิ่ม", style: .default) { (action) in
            if let textField = alertAddCateView.textFields?.first,
                let text = textField.text,
                text != ""{
                    let cate = CateFood(name: text)
                    self.saveAddNewCateFood(cate: cate)
            }else{
                self.view.makeToast("พบค่าว่าง")
            }
        }
        let btnCancle = UIAlertAction(title: "ยกเลิก", style: .cancel) { (action) in
            
        }
        alertAddCateView.addTextField { (textField) in
            textField.placeholder = "หมวดหมู่"
            textField.becomeFirstResponder()
        }
        alertAddCateView.addAction(btnCancle)
        alertAddCateView.addAction(btnConfirm)
        
        self.present(alertAddCateView, animated: true, completion: nil)
    }
    
    func saveAddNewCateFood(cate: CateFood) {
        try! realm.write {
            realm.add(cate)
            self.view.makeToast("เพิ่มรายการ \(cate.name) สำเร็จ")
            
            cates = CateFood.getCateFoods()
            self.tableView.insertRows(at: [IndexPath(row: cates.count - 1, section: 0)], with: .automatic)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CateTableViewCell.getCellIdentifier(), for: indexPath) as! CateTableViewCell

        let cate = cates[indexPath.row]
        cell.cate = cate

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openFoodInCateView" {
            let controller = segue.destination as! FoodInCateTableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                controller.cate = cates[indexPath.row]
            }
        }
    }
    

}
