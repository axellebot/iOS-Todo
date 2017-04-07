//
//  ListDetailTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

// Add UITextFieldDelegate to check when an input has been changed.

class ListDetailsTableViewController: UITableViewController {

    // MARK: Properties
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    var list: List?
    var lists: [List]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if saveButton === sender as? UIBarButtonItem {
            guard let name = listNameTextField.text else {
                return true
            }

            if (name.isEmpty) {
                displayError()
                return false
            } else {
                return true
            }
        }
        return true
    }

    func displayError() {

        let alertController = UIAlertController(title: "Empty List Name", message:
        "Please give a name to your list to create it.", preferredStyle: UIAlertControllerStyle.alert)

        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))

        self.present(alertController, animated: true, completion: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if saveButton === sender as? UIBarButtonItem {
            guard let name = listNameTextField.text else {
                return
            }
            list = List(name: name, items: [])
        }
    }
}
