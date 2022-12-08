// NewsGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Группа
struct NewsGroup: Decodable {
    /// Идентификатор группы
    let id: Int
    /// Имя
    let name: String
    /// Фото аватара
    let photoUrlString: String?

    enum CodingKeys: String, CodingKey {
        case photoUrlString = "photo_50"
        case name
        case id
    }
}
