// DataProvider.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Взаимодействие с базой данных
final class DataProvider {
    // MARK: - Public Methods

    func saveFriendsInRealm(user: [User]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveGroupsInRealm(group: [Group]) {
        do {
            let realm = try Realm()
            try realm.write {
                print(realm.configuration.fileURL)
                realm.add(group, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func savePhotoData(photos: [Photo]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(photos)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
