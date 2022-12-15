// ItemsNewsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о новостях и опубликовавших их людях, группах
struct ItemsNewsfeed: Decodable {
    /// Новости
    let newsFeed: [Newsfeed]
    /// Пользователи
    let users: [Profile]
    /// Группы
    let groups: [NewsGroup]
    /// Следующая страница новостей
    let nextPage: String

    enum CodingKeys: String, CodingKey {
        case newsFeed = "items"
        case users = "profiles"
        case groups
        case nextPage = "next_from"
    }
}
