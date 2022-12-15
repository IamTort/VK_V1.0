// Newsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новость
final class Newsfeed: Decodable {
    /// Идентификатор новости
    let sourceId: Int
    /// Дата
    let date: Double
    /// Текст
    let text: String?
    /// Имя автора
    var authorName: String?
    /// Аватар
    var avatarUrl: String?
    /// Ссылка на изображения к новости
    let attachments: [NewsPhotoPost]?
    /// Комментарии
    let comments: Comments?
    /// Лайки
    let likes: Likes?
    /// Репосты
    let reposts: Reposts?
    /// Просмотры
    let views: Views?

    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case authorName
        case avatarUrl
        case likes
        case views
        case comments
        case reposts
        case attachments
    }
}
