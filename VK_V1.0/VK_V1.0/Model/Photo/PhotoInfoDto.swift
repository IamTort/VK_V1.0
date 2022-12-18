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
    /// Высота фото
    var height: Int?
    /// Ширина фото
    var width: Int?
    /// Соотношение сторон у фотографии
    var aspectRatio: CGFloat {
        guard let height = height,
              let width = width,
              width != 0 else { return 0 }

        return (CGFloat(height) / CGFloat(width))
    }

    override class func ignoredProperties() -> [String] {
        ["width", "height", "aspectRatio"]
    }
}
