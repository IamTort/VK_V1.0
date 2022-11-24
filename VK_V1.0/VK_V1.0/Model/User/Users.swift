// Users.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Количество друзей и их массив с ними
struct Users: Decodable {
    let count: Int
    let items: [User]
}
