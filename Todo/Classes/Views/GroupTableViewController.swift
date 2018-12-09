//
//  GroupTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    // MARK: - Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var groups: [TaskGroup]!
    
    // MARK: - Actions
    @IBAction func unwindToGroupTable(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? GroupDetailTableViewController, let group = sourceViewController.taskGroup {
            // Add a new group.
            let newIndexPath = NSIndexPath(row: groups.count, section: 0)
            groups.append(group)
            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
        }
    }
    
    // MARK: - Table Controller Logic
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.groupTableViewCell.identifier, for: indexPath) as! GroupTableViewCell

        let group = groups[(indexPath as NSIndexPath).row]

        cell.groupNameLabel.text = group.name

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            //self.tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //TODO : Add delete from coredata
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let listData = groups[row]

        displayListData(data: listData)
    }
    
    // MARK: - Navigation
    func displayListData(data: TaskGroup) {
        performSegue(withIdentifier: R.segue.groupTableViewController.toGroupTasks.identifier, sender: data)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == R.segue.groupTableViewController.toGroupTasks.identifier {
            print("Preparing navigation to \"GroupTasks\"")
            guard let listData = sender as? TaskGroup else {
                return
            }
            guard let itemTableViewController = segue.destination as? TaskTableViewController else {
                return
            }
            itemTableViewController.groupData = listData
        }

        if segue.identifier == R.segue.groupTableViewController.toAddGroup.identifier {
            print("Preparing navigation to \"AddGroup\"")
        }
    }
    
    // MARK: - Functions
    fileprivate func fetchData() {
        do {
            self.groups = try context.fetch(TaskGroup.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
}


