// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Модель группы
final class Group: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var imageUrl = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "photo_50"
    }

    // MARK: - Public methods

    override class func primaryKey() -> String? {
        "id"
    }
}
