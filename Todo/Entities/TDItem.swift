//
//  TDItem.swift
//  Todo
//
//  Created by Axel Le Bot on 05/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import QueryKit
import RealmSwift
import Realm

class TDItem: Object {
    dynamic var id: String = UUID().uuidString;
    dynamic var label: String = ""
    dynamic var desc:String = ""
    dynamic var isCompleted: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }
}
