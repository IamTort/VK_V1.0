// ParseGroup.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Парсинг групп
final class ParseGroup: Operation {
    // MARK: - Public property

    var groups: [Group] = []

    // MARK: - Public methods

    override func main() {
        guard let getDataOperation = dependencies.first as? FetchDataOperation,
              let data = getDataOperation.data else { return }

        do {
            let response = try JSONDecoder().decode(ResponseGroup.self, from: data)
            groups = response.response.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
