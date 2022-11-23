// SessionInformation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Хранение данных аутентификации
final class SessionInformation {
    static let instance = SessionInformation()

    private init() {}
    var token: String?
    var userId: Int?
}
