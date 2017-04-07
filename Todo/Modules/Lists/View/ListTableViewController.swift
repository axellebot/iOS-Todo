//
//  ListTableViewController.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController {
    
    @IBOutlet weak var listsTableView: UITableView!
    var presenter: ListsPresentation!
    var lists: [List] = [] {
        didSet {
            listsTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    fileprivate func setupView() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.add,
            target: self,
            action: #selector(didClickAddButton)
        )
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = Localization.Lists.navigationBarTitle
        
        listsTableView.dataSource = self
        listsTableView.delegate = self
        listsTableView.rowHeight = UITableViewAutomaticDimension
        listsTableView.estimatedRowHeight = 128.0
        //listsTableView.register(ListTableViewCell.self)
    }
    
    @objc fileprivate func didClickAddButton(_ sender: Any?) {
        presenter.didClickAddButton()
    }
}

extension ListTableViewController: ListsView {
    
    func showNoContentScreen() {
    }
    
    func showListsData(_ lists: [List]) {
        self.lists = lists
    }
    func showActivityIndicator(){
        
    }
    func hideActivityIndicator(){
        
    }
}

extension ListTableViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return lists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.listTableViewCell, for: indexPath)!

        let list = lists[(indexPath as NSIndexPath).row]

        cell.listNameLabel.text = list.name
        cell.backgroundColor = list.color
        cell.listNameLabel.textColor = UIColor.white

        return cell
    }


    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lists.remove(at: indexPath.row)
            //self.tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }


    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectList(lists[indexPath.row])
    }
}


