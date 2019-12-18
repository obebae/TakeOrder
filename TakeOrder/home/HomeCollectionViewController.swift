//
//  HomeCollectionViewController.swift
//  TakeOrder
//
//  Created by Suban Wachaiya on 15/12/2562 BE.
//  Copyright © 2562 obebae. All rights reserved.
//

import UIKit
import RealmSwift

class HomeCollectionViewController: UICollectionViewController {
    
    private var selectTable: Table!
    
    let realm = try! Realm()
    var tables: Results<Table> = Table.getTables(filter: "active == true")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tables = Table.getTables(filter: "active == true")
        guard let collectionView = self.collectionView else { return }
        collectionView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "openOrderView",
            let orderViewController = segue.destination as? OrderViewController {
            guard let collectionView = self.collectionView else { return }
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
                orderViewController.table = tables[indexPath.row]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tables.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.getCellIdentifier(), for: indexPath) as! TableCollectionViewCell
        
        cell.setBorder()
        
        // Configure the cell
        let table = tables[indexPath.row]
        cell.table = table
    
        return cell
    }

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func actionTapButtonMenu(_ sender: UIBarButtonItem){
        guard let slideMenu = self.slideMenuController() else { return  }
        slideMenu.openLeft()
    }

}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = TableCollectionViewCell.itemsPerRow()
        let paddingSpace = TableCollectionViewCell.getSectionInsets().left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return TableCollectionViewCell.getSectionInsets()
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return TableCollectionViewCell.getSectionInsets().left
    }
}
