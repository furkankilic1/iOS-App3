//
//  Temp.swift
//  FurkanKilic_HW3
//
//  Created by CTIS Student on 11.12.2021.
//  Copyright © 2021 CTIS. All rights reserved.
//

import Foundation

class DataSource {
    var mRecordList: [Record] = []
    var categories: [String] = []
    
    func numbeOfItemsInEachCategory(index: Int) -> Int {
        return itemsInCategory(index: index).count
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func getCategoryLabelAtIndex(index: Int) -> String {
        return categories[index]
    }
    
    // MARK: - Populate Data from files
    func populate(type: String) {
        if type.lowercased() == "json" {
            if let mURL = URL(string: "http://syedali.bilkent.edu.tr/480/data.json") {
                if let data = try? Data(contentsOf: mURL) {
                    
                    // https://www.dotnetperls.com/guard-swift
                    guard let json = try? JSON(data: data) else {
                        print("Error with JSON")
                        return
                    }
                    //print(json)
                    
                    for index in 0..<json["items"].count {
                        let name = json["items"][index]["name"].string!
                        let category = json["items"][index]["category"].string!
                        let description = json["items"][index]["description"].string!
                        let image = json["items"][index]["image"].string!
                        
                        let mRecord = Record(name: name, category: category, description: description, image: image)
                        mRecordList.append(mRecord)
                        
                        if !categories.contains(category) {
                            categories.append(category)
                        }
                    }
                }
                else {
                    print("Json Data error")
                }
            }
            else {
                
            }
        }
        else {
            if let rssURL = URL(string: "http://syedali.bilkent.edu.tr/480/data.xml") {
                if let xmlToParse = try? Data(contentsOf: rssURL) {
                    
                    let xml = SWXMLHash.parse(xmlToParse)
                    //print(xml)

                    for item in xml["main"]["item"].all {
                        
                        let record: Record = Record(name: item["name"].element!.text, category: item["category"].element!.text, description: item["description"].element!.text, image: item["image"].element!.text)
                        
                        if !categories.contains(record.category) {
                            categories.append(record.category)
                        }

                        mRecordList.append(record)
                    }
                }
                else {
                    print("XML Data error")
                }
            }
        }
    }

        
        // MARK: - itemsForEachGroup
        func itemsInCategory(index: Int) -> [Record] {
            let item = categories[index]
            
            let filteredItems = mRecordList.filter { (record: Record) -> Bool in
                return record.category == item
            }
            
            return filteredItems
        }
    
    }
