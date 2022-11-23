// SessionInformation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о сессии
final class SessionInformation {
    static let instance = SessionInformation()

    // MARK: - Public property

    var token: String?
    var userId: Int?

    private init() {}
}
