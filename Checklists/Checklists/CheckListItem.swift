//
//  CheckListItem.swift
//  Checklists
//
//  Created by Rexmoon on 5/2/23.
//

import Foundation

struct CheckListItem: Equatable, Identifiable, Codable {
    var id: UUID = .init()
    var text: String = ""
    var checked: Bool = false
}
