//
//  RootRouter.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    func presentListsScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = ListsRouter.assembleModule()
    }
}
