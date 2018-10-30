//
//  ListTableViewCell.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var groupNameLabel: UILabel!

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
