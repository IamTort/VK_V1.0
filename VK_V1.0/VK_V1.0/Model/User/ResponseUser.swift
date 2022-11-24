// ResponseUser.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Отклик от сервера с данными о друзьях
struct ResponseUser: Decodable {
    let response: Users
}
