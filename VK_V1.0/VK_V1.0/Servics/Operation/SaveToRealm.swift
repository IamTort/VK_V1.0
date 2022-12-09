// SaveToRealm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сохранение в базу данных
final class SaveToRealm: Operation {
    // MARK: - Public methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseGroup else { return }
        let parseData = getParseData.outputData
        RealmService.save(items: parseData)
    }
}
