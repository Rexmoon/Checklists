//
//  CheckList.swift
//  Checklists
//
//  Created by User-P2 on 6/12/23.
//

import UIKit

struct CheckList: Equatable, Identifiable {
    let id = UUID()
    var name: String
    
    init(name: String = "Name") {
        self.name = name
    }
}

