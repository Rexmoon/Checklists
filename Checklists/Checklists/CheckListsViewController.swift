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

    private func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
        guard let label = cell.viewWithTag(1001) as? UILabel else { return }
        label.text = item.checked ? "☑️" : " "
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ItemDetailViewController else { return }
        if segue.identifier == "AddItem" {
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
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
        configureCheckmark(for: cell, with: items[indexPath.row])

        return cell
    }

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            items[indexPath.row].checked.toggle()
            configureCheckmark(for: cell, with: items[indexPath.row])
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Add Item Delegate
extension CheckListsViewController: ItemDetailViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        tableView.insertRows(at: [IndexPath(row: newRowIndex, section: 0)], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem) {
        guard
            let index = items.firstIndex(where: { $0.id == item.id }),
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
        else {
            return
        }
        items[index] = item
        configureText(for: cell, with: item)
        navigationController?.popViewController(animated: true)
    }
}
