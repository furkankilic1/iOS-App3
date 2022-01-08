//
//  JsonVC.swift
//  FurkanKilic_HW3
//
//  Created by CTIS Student on 11.12.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit

class JsonVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    
    let mDataSource = DataSource()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mDataSource.numberOfCategories()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDataSource.numbeOfItemsInEachCategory(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let items: [Record] = mDataSource.itemsInCategory(index: indexPath.section)
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(named: item.image.lowercased())
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label : UILabel = UILabel()
        
        label.text = mDataSource.getCategoryLabelAtIndex(index: section)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28.0)
        label.textColor = UIColor.purple
        label.backgroundColor = UIColor.systemYellow
        label.textAlignment = NSTextAlignment.center;
        
        return label
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailVcId"){
            
            if let indexPath = getIndexPathForSelectedRow() {
                
                let record = mDataSource.itemsInCategory(index: indexPath.section)[indexPath.row]
                
                let detailViewController = segue.destination as! DetailVC
                
                detailViewController.mRecord = record
            }
        }
        
    }
    
    func getIndexPathForSelectedRow() -> IndexPath? {
        var indexPath: IndexPath?
        
        if mTableView.indexPathsForSelectedRows!.count > 0 {
            indexPath = mTableView.indexPathsForSelectedRows![0] as IndexPath
        }
        
        return indexPath
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        mDataSource.populate(type: "json")
        // Do any additional setup after loading the view.
    }
    
    
}
