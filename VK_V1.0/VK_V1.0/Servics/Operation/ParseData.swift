// ParseData.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Парсинг
final class ParseData: Operation {
    // MARK: - Public property

    var outputData: [Group] = []

    // MARK: - Public methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }

        do {
            let response = try JSONDecoder().decode(ResponseGroup.self, from: data)
            outputData = response.response.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
