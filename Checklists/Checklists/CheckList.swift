//
//  CheckList.swift
//  Checklists
//
//  Created by User-P2 on 6/12/23.
//

import UIKit

struct CheckList: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String
    var items: [CheckListItem] = []
    
    init(name: String = "Name") {
        self.name = name
    }
}

