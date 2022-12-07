// ItemsNewsfeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о новостях и опубликовавших их людях, группах
struct ItemsNewsfeed: Decodable {
    /// Новости
    let items: [Newsfeed]
    /// Профили людей
    let profiles: [NewsProfile]
    /// Профили групп
    let groups: [NewsGroup]
}
