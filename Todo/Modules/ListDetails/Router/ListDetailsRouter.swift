//
//  ListDetailsRouter.swift
//  Todo
//
//  Created by Axel Le Bot on 07/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class ListDetailsRouter: ListDetailsWireframe {

    weak var viewController: UIViewController?
    
    func presentBack() {
        viewController?.dismiss(animated: true)
    }
    
    static func assembleModule() -> UIViewController {
        let view = R.storyboard.listDetailsStoryboard.listDetailsViewController()
        let presenter = ListDetailsPresenter()
        
        view?.presenter = presenter
        
        presenter.view = view
        
        return view!
    }
    
    static func assembleModule(_ listId:String) -> UIViewController {
        let view = R.storyboard.listDetailsStoryboard.listDetailsViewController()
        let presenter = ListDetailsPresenter()
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.listId = listId
        
        return view!
    }
}
