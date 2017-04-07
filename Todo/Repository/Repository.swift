///
//  Repository.swift
//  Todo
//
// Created by Axel Le Bot on 02/03/2017.
// Copyright (c) 2017 Axel Le Bot. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

func abstractMethod() -> Never {
    fatalError("abstract method")
}

class AbstractRepository<T> {

    func queryAll() -> Observable<[T]> {
        abstractMethod()
    }

    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        abstractMethod()
    }

    func save(entity: T) -> Observable<Void> {
        abstractMethod()
    }

    func save(entityList: [T]) -> Observable<Void> {
        abstractMethod()
    }

    func delete(entity: T) -> Observable<Void> {
        abstractMethod()
    }

    func delete(entityList: [T]) -> Observable<Void> {
        abstractMethod()
    }
}

final class Repository<T:Object>: AbstractRepository<T> where T:Object {
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "me.lebot.todo.realmPlatform"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    override func queryAll() -> Observable<[T]> {
        return Observable.deferred {
                    let realm = self.realm
                    let objects = realm.objects(T.self)

                    return Observable.array(from: objects)
                }
                .subscribeOn(scheduler)
    }

    override func query(with predicate: NSPredicate,
                        sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        return Observable.deferred {
                    let realm = self.realm
                    let objects = realm.objects(T.self)
                            .filter(predicate)
                            .sorted(by: sortDescriptors.map(SortDescriptor.init))

                    return Observable.array(from: objects)
                }
                .subscribeOn(scheduler)
    }

    override func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            let realm = self.realm
            return realm.rx.save(entity: entity)
        }.subscribeOn(scheduler)
    }

    override func save(entityList: [T]) -> Observable<Void> {
        return Observable.deferred {
            let realm = self.realm
            return realm.rx.save(entityList: entityList)
        }.subscribeOn(scheduler)
    }

    override func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
                    return self.realm.rx.delete(entity: entity)
                }
                .subscribeOn(scheduler)
    }

    override func delete(entityList: [T]) -> Observable<Void> {
        return Observable.deferred {
                    return self.realm.rx.delete(entityList: entityList)
                }
                .subscribeOn(scheduler)
    }

}
