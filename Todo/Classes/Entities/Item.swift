//
//  Item.swift
//  ToDoList
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class Item {
    var title: String
    var description: String?
    var isCompleted: Bool = false

    init(title providedTitle: String, description providedDescription: String?) {
        title = providedTitle
        description = providedDescription
    }
}
