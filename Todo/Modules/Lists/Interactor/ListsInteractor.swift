//
//  ListInteractor.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class ListsInteractor: ListsUseCase {

    weak var output: ListsInteractorOutput!
    private var disposeBag = DisposeBag()

    func deleteList(_ list: TDList) {
    }

    func fetchLists() {
//        let lists: [TDList] = [
//            TDList(name: "🚣 Sport", items: [
//                Item(title: "Push-up 💪", description: nil)
//                ]),
//            TDList(name: "🎓 Studies", items: [
//                Item(title: "Finish iOS project", description: "Project for Gael Robin"),
//                ]),
//            TDList(name: "💼 Pro", items: [
//                Item(title: "Find a new company", description: nil),
//                ])
//        ]

        let lists :[TDList] = [];
        
        self.output.listsFetched(lists)
    }

}
