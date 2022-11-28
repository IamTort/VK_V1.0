// ResponsePhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Отклик от сервера с данными о фотографиях
struct ResponsePhoto: Decodable {
    let response: Photos
}
