//
//  ViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/1/23.
//

import UIKit

final class CheckListsViewController: UITableViewController {

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        10
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItemCell", for: indexPath)

        guard let label = cell.viewWithTag(1000) as? UILabel else { return UITableViewCell() }

        label.text = "You're on: \(indexPath.row + 1) row"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = cell.accessoryType == .none ?
                .checkmark :
                .none
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
