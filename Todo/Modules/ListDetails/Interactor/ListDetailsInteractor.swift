//
//  ListDetailsInteractor.swift
//  Todo
//
//  Created by Axel Le Bot on 06/04/2017.
//  Copyright © 2017 Axel Le Bot. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

class ListDetailsInteractor: ListDetailsUseCase {

    weak var output: ListDetailsInteractorOutput!
    private var disposeBag = DisposeBag()

    func saveList(_ list : TDList){

    }
    
    func fetchList(_ id : String){
        
    }
}
