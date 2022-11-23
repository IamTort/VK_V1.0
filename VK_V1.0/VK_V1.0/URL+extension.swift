// URL+extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для создания ссылки
extension URL {
    private enum Constants {
        static let accessToken = "access_token"
        static let scheme = "https"
        static let host = "api.vk.com"
        static let error = ""
    }

    static func configureURL(token: String, typeMethod: String, paramsMap: [String: String]) -> URL {
        var queryItems: [URLQueryItem] = []
        paramsMap.forEach { name, value in
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        queryItems.append(.init(name: Constants.accessToken, value: token))

        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = typeMethod
        components.queryItems = queryItems

        guard let url = components.url else { fatalError(Constants.error) }
        return url
    }
}
