//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/3/23.
//

import UIKit

protocol ItemDetailViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController)
    func addItemViewController(_ controller: ItemDetailViewController, item: CheckListItem)
    func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem)
}

final class ItemDetailViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var doneButton: UIBarButtonItem!
    
    // MARK: - Properties
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: CheckListItem?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemToEdit {
            title = "Edit Item"
            textField.text = itemToEdit.text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if var itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: itemToEdit)
        } else {
            var item = CheckListItem()
            item.text = textField.text ?? ""
            delegate?.addItemViewController(self, item: item)
        }
    }
    
    // MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
}

// MARK: UITextField Delegates
extension ItemDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneButton.isEnabled = !newText.isEmpty
        
        return true
    }
}
