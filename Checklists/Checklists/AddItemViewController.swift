//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/3/23.
//

import UIKit

final class AddItemViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        print("\(textField.text ?? "")")
        navigationController?.popViewController(animated: true)
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
