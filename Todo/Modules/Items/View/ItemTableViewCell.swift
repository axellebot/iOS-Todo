//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit
import BEMCheckBox


//
//protocol ItemTableViewCellDelegate: class {
//    func switchStatus(forItem item: Item, cell: ItemTableViewCell, sender: UIButton)
//}

class ItemTableViewCell: UITableViewCell {

    //var item: Item?
    var onClick: ((ItemTableViewCell) -> ())?

    //func functionName(name: ItemTableViewCell) -> ()
    // MARK: Properties
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: BEMCheckBox!


    @IBAction func buttonTapped(_ sender: BEMCheckBox) {
        onClick?(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
