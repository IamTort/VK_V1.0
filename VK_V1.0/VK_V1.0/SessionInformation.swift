// SessionInformation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о текущей сессии пользователя
final class SessionInformation {
    // MARK: - Public property

    static let shared = SessionInformation()
    var token: String?
    var userId: Int?

    // MARK: - Initializers

    private init() {}
}
