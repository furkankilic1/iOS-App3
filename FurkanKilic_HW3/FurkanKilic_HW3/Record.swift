//
//  Record.swift
//  CTIS480_Fall2122_HW3
//
//  Created by CTIS Student on 4.12.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//


import Foundation

class Record {
    var name: String
    var category: String
    var description: String
    var image: String
    
    init(name: String, category: String, description: String, image: String) {
        self.category = category
        self.name = name
        self.description = description
        self.image = image
    }
        
}
