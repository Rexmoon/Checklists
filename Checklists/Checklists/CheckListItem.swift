//
//  CheckListItem.swift
//  Checklists
//
//  Created by Rexmoon on 5/2/23.
//

import Foundation

struct CheckListItem: Equatable, Identifiable {
    let id = UUID()
    var text: String = ""
    var checked: Bool = false
}
