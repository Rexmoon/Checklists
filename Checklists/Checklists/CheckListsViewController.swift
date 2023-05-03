//
//  ViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/1/23.
//

import UIKit

final class CheckListsViewController: UITableViewController {
    // MARK: - Properties
    var items = [CheckListItem]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setItems()
    }

    // MARK: - Functions
    private func setItems() {
        let row0item = CheckListItem(text: "Walk the dog")
        let row1item = CheckListItem(text: "Brush my teeth", checked: true)
        let row2item = CheckListItem(text: "Learn iOS development", checked:  true)
        let row3item = CheckListItem(text: "Soccer practice")
        let row4item = CheckListItem(text: "Eat ice cream", checked: true)
        items.append(row0item)
        items.append(row1item)
        items.append(row2item)
        items.append(row3item)
        items.append(row4item)
    }

    private func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        guard let label = cell.viewWithTag(1000) as? UILabel else { return }
        label.text = item.text
    }

    private func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        var isChecked = false

        let item = items[indexPath.row]
        isChecked = item.checked

        cell.accessoryType = isChecked ? .checkmark : .none
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItemCell", for: indexPath)

        configureText(for: cell, with: items[indexPath.row])
        configureCheckmark(for: cell, at: indexPath)

        return cell
    }

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            items[indexPath.row].checked.toggle()
            configureCheckmark(for: cell, at: indexPath)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
