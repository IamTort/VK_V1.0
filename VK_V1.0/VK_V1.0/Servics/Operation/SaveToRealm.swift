// SaveToRealm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение в базу данных
final class SaveToRealm: Operation {
    // MARK: - Public methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseData else { return }
        let parseData = getParseData.outputData
        DataProvider.save(items: parseData)
    }
}
