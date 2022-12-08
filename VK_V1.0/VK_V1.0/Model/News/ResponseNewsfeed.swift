// ResponseNewsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Отклик от сервера с данными о новостях
struct ResponseNewsfeed: Decodable {
    let response: ItemsNewsfeed
}
