// PhotoInfoDto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Информация о фото
final class PhotoInfoDto: Object, Decodable {
    /// Ссылка на фото
    @objc dynamic var url: String = ""
    /// Тип фото
    @objc dynamic var type: String = ""
}
