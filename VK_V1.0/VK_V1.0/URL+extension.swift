// URL+extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для создания ссылки
extension URL {
    private enum Constants {
        static let accessTokenName = "access_token"
        static let schemeValue = "https"
        static let hostValue = "api.vk.com"
    }

    static func configureURL(token: String, typeMethod: String, paramsMap: [String: String]) -> URL? {
        var queryItems: [URLQueryItem] = []
        paramsMap.forEach { name, value in
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        queryItems.append(URLQueryItem(name: Constants.accessTokenName, value: token))

        var components = URLComponents()
        components.scheme = Constants.schemeValue
        components.host = Constants.hostValue
        components.path = typeMethod
        components.queryItems = queryItems

        guard let url = components.url else { return nil }
        return url
    }
}
