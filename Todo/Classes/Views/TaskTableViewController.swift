//
//  TaskTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    // MARK: - Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var groupData: TaskGroup!
    var segmentedTasks: [Task]!
    
    //MARK: Outlets
    // segment switch outlet
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!

    // MARK: - Actions
    // segment switch action
    @IBAction func segmentedControlActionChanged(_ sender: AnyObject) {
        getSegmentItems()
        self.tableView.reloadData()
    }

    // MARK: - Table Controller Logic
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up segment Items to show
        getSegmentItems()

        self.title = groupData.name! + " List"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let segment = segmentedTasks else {
            return 0
        }
        return segment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        
        //load item
        let task = segmentedTasks[(indexPath as NSIndexPath).row]

        //set item name
        cell.taskNameLabel.text = task.name

        //on checkbox click
        cell.onClick = { cell in
            guard let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            let task = self.segmentedTasks[indexPath.row]
            print("Row \(String(describing: task.name)) ")

            //switch status
            task.isDone = !task.isDone
            
            // Save the data to coredata
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
            tableView.reloadData()
        }

        //returning correct icons and colors for each item's status
        if task.isDone {
            cell.checkBoxButton.setOn(true, animated:true)
            cell.taskNameLabel.textColor = UIColor.gray
        } else {
            cell.checkBoxButton.setOn(false, animated:true)
            cell.taskNameLabel.textColor = UIColor.black
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        //let items = listData.items
        //guard let item = segmentItems[row] else { return }
        let item = segmentedTasks[row]
        displayItemDetails(item: item)
    }

    func displayItemDetails(item: Task) {
        performSegue(withIdentifier: R.segue.taskTableViewController.toTaskDetails.identifier, sender: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //add if to compare segue.identifier!!!!!
        if segue.identifier == R.segue.taskTableViewController.toTaskDetails.identifier {

            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem

            guard let task = sender as? Task else {
                return
            }
            guard let itemDetailViewController = segue.destination as? TaskDetailTableViewController else {
                return
            }
            itemDetailViewController.task = task
        }

        if segue.identifier == R.segue.taskTableViewController.addTask.identifier {
            print("Adding new item.")

            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            // TODO: will crash on deleting complete items, from the item view
            // Delete from CoreData
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(segmentedTasks[row])
            
            getSegmentItems()

            tableView.reloadData()
            //let count = segmentItems.count
            //let newIndexPath = NSIndexPath(row: count, section: 0)
            //tableView.deleteRows(at: [newIndexPath as IndexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // get the item from the edit view // function sender parameter is a segue, and is used in IB in the Exit button
    // from the Apple Food Tracker tutorial
    @IBAction func unwindToTaskTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TaskDetailTableViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                //listData.items[selectedIndexPath.row] = item
                segmentedTasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Go back to All segment if adding an item from the Done segment
                if statusSegmentControl.selectedSegmentIndex == 2 {
                    statusSegmentControl.selectedSegmentIndex = 1
                }

                let count = groupData.tasks?.count
                let newIndexPath = NSIndexPath(row: count!, section: 0)
                print(newIndexPath.row)

                //add item to list
                groupData.addToTasks(task)
                
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                
                getSegmentItems()

                tableView.reloadData()
            }
        }
    }

    
    // MARK: - Functions
    func getSegmentItems() {
        let tasks = groupData.tasks
        
        var allTasks: [Task] = []
        var completedTasks: [Task] = []
        var newTasks: [Task] = []
        
        // Sorting Tasks
        for case let task as Task in tasks! {
            if task.isDone {
                completedTasks.append(task)
            } else {
                newTasks.append(task)
            }
            allTasks.append(task)
        }
        
        // Display
        switch (statusSegmentControl.selectedSegmentIndex) {
        case 0:
            segmentedTasks = newTasks
        case 2:
            segmentedTasks = completedTasks
        default:
            segmentedTasks = allTasks
        }
    }

    
}
