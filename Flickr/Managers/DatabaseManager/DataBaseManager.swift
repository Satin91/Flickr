//
//  DataBaseManager.swift
//  Flickr
//
//  Created by Артур Кулик on 02.06.2023.
//

import RealmSwift

protocol DatabaseManagerProtocol {
    func save(object: Object)
    func update(object: Object)
    func delete(object: Object)
    func deleteAll()
    func fetch<T>(type: T.Type) -> RealmSwift.Results<T> where T: Object
}

class DatabaseManager: DatabaseManagerProtocol {
    private let realm = try! Realm()
    
    func save(object: RealmSwift.Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func update(object: RealmSwift.Object) {
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete(object: RealmSwift.Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func fetch<T>(type: T.Type) -> RealmSwift.Results<T> where T: Object {
        realm.objects(type)
    }
}
