//
//  ListDetailsPresenter.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation

class ListDetailsPresenter: ListDetailsPresentation {

    weak var view: ListDetailsView?
    var interactor: ListDetailsUseCase!
    var router: ListDetailsWireframe!

    var listId : String?
    
    func viewDidLoad() {
        interactor.fetchList(listId!)
        view?.showActivityIndicator()
    }

    func didClickCancelButton() {
        router.presentBack()
    }

    func didClickSaveButton(){
        router.presentBack()
    }
}

extension ListDetailsPresenter: ListDetailsInteractorOutput {

    func listFetched(_ list: TDList) {
        view?.hideActivityIndicator()
        view?.showListData(list)
    }

    internal func listFetchFailed() {
        view?.showNoContentScreen()
        view?.hideActivityIndicator()
    }
}
