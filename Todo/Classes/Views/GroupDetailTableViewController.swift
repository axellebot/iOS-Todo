//
//  ListDetailTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class GroupDetailTableViewController: UITableViewController {
    // MARK: - Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var taskGroup:TaskGroup?
    
    // MARK: - Outlets
    @IBOutlet weak var taskGroupNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Controller Logic
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
            guard let name = taskGroupNameTextField.text else {
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

    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If Saved button used
        if saveButton === sender as? UIBarButtonItem {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            taskGroup = TaskGroup(context: context)
            taskGroup?.name = taskGroupNameTextField.text
            // Save data to coredata
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Functions
    func displayError() {
        let alertController = UIAlertController(title: "Empty List Name", message:
            "Please give a name to your list to create it.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
