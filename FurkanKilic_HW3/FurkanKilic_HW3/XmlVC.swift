//
//  XmlVC.swift
//  FurkanKilic_HW3
//
//  Created by CTIS Student on 11.12.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class XmlVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    let mDataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mDataSource.populate(type: "xml")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mDataSource.numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mDataSource.numbeOfItemsInEachCategory(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        
        let items: [Record] = mDataSource.itemsInCategory(index: indexPath.section)
        let item = items[indexPath.row]
        
        cell.cellImageView.image = UIImage(named: item.image.lowercased())
        cell.cellLabel.text = item.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CustomCollectionReusableView
        
        let items: [Record] = mDataSource.itemsInCategory(index: indexPath.section)
    
        headerView.headerLabel.text = items[0].category
      
        return headerView
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailVcXmlId"){
            
            if let indexPath = getIndexPathForSelectedRow() {
                
                let record = mDataSource.itemsInCategory(index: indexPath.section)[indexPath.row]
                
                let detailViewController = segue.destination as! DetailVC
                
                detailViewController.mRecord = record
            }
        }
        
    }
    
    func getIndexPathForSelectedRow() -> IndexPath? {
        
        var indexPath: IndexPath?

        if mCollectionView.indexPathsForSelectedItems!.count > 0 {
            indexPath = mCollectionView.indexPathsForSelectedItems![0] as IndexPath
        }
               
        
        return indexPath
    }
    

}
