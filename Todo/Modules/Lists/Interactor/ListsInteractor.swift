//
//  ListInteractor.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation
import RxSwift

class ListsInteractor: ListsUseCase {
    
    weak var output: ListsInteractorOutput!
    private var disposeBag = DisposeBag()
    
    func fetchLists() {
        let lists: [List] = [
            List(name: "🚣 Sport", items: [
                Item(title: "Push-up 💪", description: nil)
                ]),
            List(name: "🎓 Studies", items: [
                Item(title: "Finish iOS project", description: "Project for Gael Robin"),
                ]),
            List(name: "💼 Pro", items: [
                Item(title: "Find a new company", description: nil),
                ])
        ]

        self.output.listsFetched(lists)
    }
}
