//
//  ViewProtocols.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation

protocol ReusableView: class {}

protocol NibLoadableView: class { }

protocol IndicatableView: class {
    func showActivityIndicator()
    func hideActivityIndicator()
    func displayErrorMessage(_ message : String)
}
