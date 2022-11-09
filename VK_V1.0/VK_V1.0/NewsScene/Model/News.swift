// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель новости
struct News {
    let avatarImageName: String
    let name: String
    let time: String
    let description: String?
    let photoImageName: String
    let likeCount: Int
    let viewsCount: Int
}
