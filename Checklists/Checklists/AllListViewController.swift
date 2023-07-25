//
//  AllListViewController.swift
//  Checklists
//
//  Created by Rexmoon on 6/12/23.
//

import UIKit

final class AllListViewController: UITableViewController {

    let cellIdentifier: String = "CheckListCellIdentifier"
    
    private var lists = Array<CheckList>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Checklists"
        
        (1...10).forEach { index in
            lists.append(CheckList(name: "List Number \(index)"))
        }
    }
    
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheckLists" {
            guard
                let controller = segue.destination as? CheckListsViewController,
                let checkList = sender as? CheckList
            else {
                return
            }
            controller.checkList = checkList
        } else if segue.identifier == "addChecklist" {
            guard
                let controller = segue.destination as? ListDetailViewController
            else {
                return
            }
            controller.delegate = self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCheckLists", sender: lists[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard
            let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as? ListDetailViewController
        else {
            return
        }
        
        controller.delegate = self
        controller.checklistToEdit = lists[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - ListDetail delegate

extension AllListViewController: ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: CheckList) {
        guard let index = lists.firstIndex(where: { $0.id == checklist.id }) else { return }
        lists[index] = checklist
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: CheckList) {
        guard
            let index = lists.firstIndex(where: { $0.id == checklist.id }),
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
        else {
            return
        }
        cell.textLabel?.text = checklist.name
        navigationController?.popViewController(animated: true)
    }
}
