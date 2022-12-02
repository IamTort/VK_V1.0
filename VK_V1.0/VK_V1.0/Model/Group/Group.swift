// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Модель группы
final class Group: Object, Decodable {
    /// Идентификатор
    @objc dynamic var id = 0
    /// Название группы
    @objc dynamic var name = ""
    /// Ссылка на фото аватарки
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
