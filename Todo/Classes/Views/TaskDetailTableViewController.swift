//
//  TaskDetailTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    // MARK: - Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: Task!
    var taskGroup: TaskGroup!
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        //if from modal, dismiss the page
        if (presentingViewController != nil) {
            dismiss(animated: true, completion: nil)
        }
        //if from push, pop the view
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }


    // MARK: - Controller Logic
    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = task {
            self.title = "Edit Task"
            taskNameTextField.text = task.name
            taskDescriptionTextField.text = task.desc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // If Saved button used
        if saveButton === sender as? UIBarButtonItem {
            guard let name = taskNameTextField.text else {
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

    // send back to previous view // using exit and unwindToView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If Saved button used
        if saveButton === sender as? UIBarButtonItem {
            task = Task(context: context) // Link Task & Context
            task.name = taskNameTextField.text ?? ""
            task.desc = taskDescriptionTextField.text ?? ""
            task.isDone=false
            
            // Save the data to coredata
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
        let alertController = UIAlertController(title: "Empty Item Name", message:
            "Please enter a to-do before saving", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
