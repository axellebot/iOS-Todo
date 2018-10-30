//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit
import BEMCheckBox

class TaskTableViewCell: UITableViewCell {

    //var item: Item?
    var onClick: ((TaskTableViewCell) -> ())?

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: BEMCheckBox!

    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: BEMCheckBox) {
        onClick?(self)
    }

    // MARK: - Cell Logic
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
