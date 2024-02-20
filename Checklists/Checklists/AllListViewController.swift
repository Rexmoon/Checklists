//
//  AllListViewController.swift
//  Checklists
//
//  Created by Rexmoon on 6/12/23.
//

import UIKit

final class AllListViewController: UITableViewController {

    let cellIdentifier: String = "CheckListCellIdentifier"
    
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Checklists"
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
        dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = dataModel.lists[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCheckLists", sender: dataModel.lists[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard
            let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as? ListDetailViewController
        else {
            return
        }
        
        controller.delegate = self
        controller.checklistToEdit = dataModel.lists[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - ListDetail delegate

extension AllListViewController: ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: CheckList) {
        dataModel.lists.append(checklist)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: CheckList) {
        guard let index = dataModel.lists.firstIndex(where: { $0.id == checklist.id }) else { return }
        dataModel.lists[index] = checklist
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
