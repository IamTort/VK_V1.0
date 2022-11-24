// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Модель группы
class Group: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "photo_50"
    }
}
