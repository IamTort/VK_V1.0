// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Фотография
@objcMembers
final class Photo: Object, Decodable {
    dynamic var sizes = List<PhotoInfoDto>()
}
