// DataProvider.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Взаимодействие с базой данных
final class DataProvider {
    // MARK: - Public property

    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    static func save<T: Object>(items: [T], update: Bool = true) {
        do {
            let realm = try Realm()
            try realm.write {
                switch update {
                case true:
                    realm.add(items, update: .modified)
                case false:
                    realm.add(items)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadData<T: Object>(items: T.Type) -> Results<T>? {
        var groups: Results<T>?
        do {
            let realm = try Realm()
            groups = realm.objects(T.self)
        } catch {
            print(error.localizedDescription)
        }
        return groups
    }

    func deleteGroup(_ group: Group) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
