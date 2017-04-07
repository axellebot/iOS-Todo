//
//  ListDetailTableViewController.swift
//  Todo
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit
import PKHUD

class ListDetailsTableViewController: UITableViewController {

    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var presenter: ListDetailsPresentation!
    var list: TDList?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.viewDidLoad()
    }

    fileprivate func  setupView() {
        let cancelButton = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self,
                action: #selector(didClickCancelButton)
        )

        let saveButton = UIBarButtonItem(
                barButtonSystemItem: .save,
                target: self,
                action: #selector(didClickSaveButton)
        )
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = Localization.ListDetails.navigationBarTitle
    }

    @objc fileprivate func didClickCancelButton(_ sender: Any?) {
        presenter.didClickCancelButton()
    }

    @objc fileprivate func didClickSaveButton(_ sender: Any?) {
        presenter.didClickSaveButton()
    }
}

extension ListDetailsTableViewController: ListDetailsView {
    
    func showNoContentScreen(){
        
    }
    
    func showListData(_ list: TDList) {
        self.list = list
        self.listNameTextField.text = list.label
    }

    func showActivityIndicator(){
        HUD.show(.progress)
    }
    func hideActivityIndicator(){
        HUD.flash(.success, delay: 1.0)
    }

    func displayErrorMessage(_ message: String){
        HUD.flash(.label(message), delay: 2.0)
    }
}
