//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/3/23.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, item: CheckListItem)
}

final class AddItemViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Properties
    weak var delegate: AddItemViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        var item = CheckListItem()
        item.text = textField.text ?? ""
        delegate?.addItemViewController(self, item: item)
    }
    
    // MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
}

// MARK: UITextField Delegates
extension AddItemViewController: UITextFieldDelegate {
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
