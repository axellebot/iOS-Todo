//
//  ListDetailsContract.swift
//  Todo
//
//  Created by Axel Le Bot on 07/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

protocol ListDetailsView: IndicatableView {
    var presenter: ListDetailsPresentation! { get set }
    
    func showNoContentScreen()
    func showListData(_ listDetails: TDList)
}

protocol ListDetailsPresentation: class {
    weak var view: ListDetailsView? { get set }
    var interactor: ListDetailsUseCase! { get set }
    var router: ListDetailsWireframe! { get set }

    func viewDidLoad()

    func didClickCancelButton()
    func didClickSaveButton()
}

protocol ListDetailsUseCase: class {
    weak var output: ListDetailsInteractorOutput! { get set }

    func saveList(_ list: TDList)
    func fetchList(_ id : String)
}

protocol ListDetailsInteractorOutput: class {
    func listFetched(_ list: TDList)
    func listFetchFailed()
}

protocol ListDetailsWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func presentBack()
    
    static func assembleModule() -> UIViewController
    static func assembleModule(_ listId : String) -> UIViewController
}
