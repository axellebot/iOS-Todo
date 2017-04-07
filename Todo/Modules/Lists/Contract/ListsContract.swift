//
//  ListsContract.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

protocol ListsView: IndicatableView {
    var presenter: ListsPresentation! { get set }
    
    func showNoContentScreen()
    func showListsData(_ lists: [TDList])
}

protocol ListsPresentation: class {
    weak var view: ListsView? { get set }
    var interactor: ListsUseCase! { get set }
    var router: ListsWireframe! { get set }
    
    func viewDidLoad()
    
    func didSelectList(_ list: TDList)
    func didClickAddButton()
}

protocol ListsUseCase: class {
    weak var output: ListsInteractorOutput! { get set }

    func deleteList(_ list : TDList)
    func fetchLists()
}

protocol ListsInteractorOutput: class {
    func listsFetched(_ lists: [TDList])
    func listsFetchFailed()
}

protocol ListsWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func presentItems(forList list: TDList)
    func presentAddList()
    
    static func assembleModule() -> UIViewController
}
