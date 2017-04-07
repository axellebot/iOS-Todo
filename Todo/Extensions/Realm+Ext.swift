//
//  Realm+Ext.swift
//  Todo
//
// Created by Axel Le Bot on 02/03/2017.
// Copyright (c) 2017 Axel Le Bot. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension List {
    func map<U>(_ f: (T) throws -> U) rethrows -> [U] {
        var mapped = [U]()
        for item in self {
            mapped.append(try f(item))
        }
        return mapped
    }
}

extension Object {
    static func build<O:Object>(_ builder: (O) -> ()) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.keyPath = sortDescriptor.key ?? ""
        self.ascending = sortDescriptor.ascending
    }
}

extension Reactive where Base: Realm {
    func save<T:Object>(entity: T, update: Bool = true) -> Observable<Void> where T: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity, update: update)
                }
                observer.onNext()
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func save<T:Object>(entityList: [T], update: Bool = true) -> Observable<Void> where T: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    for entity in entityList {
                        self.base.add(entity, update: update)
                    }
                }
                observer.onNext()
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete<T:Object>(entity: T) -> Observable<Void> where T: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(entity)
                }
                observer.onNext()
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete<T:Object>(entityList: [T]) -> Observable<Void> where T: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    for entity in entityList {
                        self.base.delete(entity)
                    }
                }
                observer.onNext()
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

}
