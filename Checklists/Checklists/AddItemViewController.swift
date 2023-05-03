//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Rexmoon on 5/3/23.
//

import UIKit

final class AddItemViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
