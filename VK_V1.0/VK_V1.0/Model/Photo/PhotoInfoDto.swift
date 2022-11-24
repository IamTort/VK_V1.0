// PhotoInfoDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Информация о фото
class PhotoInfoDto: Object, Decodable {
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
}
