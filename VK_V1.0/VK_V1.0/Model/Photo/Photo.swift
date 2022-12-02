// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотография
@objcMembers
final class Photo: Object, Decodable {
    /// Фотография разных типов
    dynamic var sizes = List<PhotoInfoDto>()
}
