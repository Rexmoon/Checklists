//
//  DataModel.swift
//  Checklists
//
//  Created by User-P2 on 7/26/23.
//

import Foundation

final class DataModel {
    var lists: [CheckList] = []
    
    init() {
        loadChecklists()
    }
}

// MARK: - Data Persistence

extension DataModel {
    
    func docummentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func dataFilePath() -> URL {
        docummentDirectory().appending(component: "Checklists.plist")
    }
    
    func saveChecklists() {
        let enconder = PropertyListEncoder()
        
        do {
            let data = try enconder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    
    func loadChecklists() {
        let encoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: dataFilePath())
            let decodedData = try encoder.decode([CheckList].self, from: data)
            lists = decodedData
        } catch {
            print(error)
        }
    }
}
