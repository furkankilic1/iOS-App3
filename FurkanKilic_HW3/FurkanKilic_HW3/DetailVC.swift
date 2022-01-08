//
//  DetailVC.swift
//  FurkanKilic_HW3
//
//  Created by CTIS Student on 11.12.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mText: UITextView!
    @IBOutlet weak var mTitle: UINavigationItem!
    
    var mRecord: Record?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = mRecord {
            mTitle.title = record.name
            mText.text = record.description
            
            let imageURL = "http://syedali.bilkent.edu.tr/480/images" + "/" + record.image
            
            AF.request(imageURL).response { response in
                if let data = response.data {
                    DispatchQueue.main.async {
                        self.mImage.image = UIImage(data: data)
                    }
                }
            }
            
        }

    }

}
