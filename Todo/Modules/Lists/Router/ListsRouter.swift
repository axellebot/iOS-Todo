//
//  ListsRouter.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class ListsRouter: ListsWireframe {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = R.storyboard.listsStoryboard.listsTableViewController()
        let presenter = ListsPresenter()
        let interactor = ListsInteractor()
        let router = ListsRouter()
        
        let navigation = UINavigationController(rootViewController: view!)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    func presentItems(forList list: List) {
        
    }
    
    func presentAddList(){
        
    }
}
