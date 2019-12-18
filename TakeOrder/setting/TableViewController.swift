//
//  TableViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift
import Toast_Swift

class TableViewController: UITableViewController {
    
    let realm = try! Realm()
    lazy var tables: Results<Table> = Table.getTables()
    //{ self.realm.objects(Table.self) }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionTapButtonMenu(_ sender: UIBarButtonItem) {
        guard let slideMenu = self.slideMenuController() else { return  }
        slideMenu.openLeft()
    }
    
    @IBAction func actionTapButtonAddTable(_ sender: UIBarButtonItem) {
        let alertAddTableView = UIAlertController(title: "เพิ่มรายการโต๊ะ", message: nil, preferredStyle: .alert)
        alertAddTableView.addTextField { (textField) in
            textField.placeholder = "ชื่อโต๊ะ"
            textField.becomeFirstResponder()
        }
        let btnConfirm = UIAlertAction(title: "เพิ่ม", style: .default) { (action) in
            if let textField = alertAddTableView.textFields?.first,
                let text = textField.text,
                text != "" {
                let table = Table(name: text)
                self.saveAddNewTable(table: table)
            }else{
                self.view.makeToast("พบค่าว่าง")
            }
        }
        let btnCancle = UIAlertAction(title: "ยกเลิก", style: .cancel)
        alertAddTableView.addAction(btnCancle)
        alertAddTableView.addAction(btnConfirm)
        
        self.present(alertAddTableView, animated: true, completion: nil)
    }
    
    func saveAddNewTable(table: Table) {
        try! realm.write {
            realm.add(table)
            self.view.makeToast("เพิ่มรายการ \(table.name) สำเร็จ")
            tables = Table.getTables()
            self.tableView.insertRows(at: [IndexPath(row: tables.count - 1, section: 0)], with: .automatic)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tables.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.getCellIdentifier(), for: indexPath) as! TableViewCell

        let table = tables[indexPath.row]
        cell.table = table
        
        return cell
    }
    
}
