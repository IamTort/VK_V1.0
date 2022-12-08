// Profile.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о пользователе опубликовавшем новость
struct Profile: Decodable {
    /// Идентификатор пользователя
    let id: Int
    /// Аватар
    let photoUrlString: String?
    /// Имя
    let firstName: String
    /// Фамилия
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case photoUrlString = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
        case id
    }
}
