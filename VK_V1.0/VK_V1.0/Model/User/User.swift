// User.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Друг
final class User: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }

    // MARK: - Public methods

    override class func primaryKey() -> String? {
        "id"
    }
}
