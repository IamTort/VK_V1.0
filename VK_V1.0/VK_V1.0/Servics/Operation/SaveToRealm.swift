// SaveToRealm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Операция сохранения в реалм
final class SaveToRealm: Operation {
    // MARK: - Public methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseGroup else { return }
        let parseData = getParseData.groups
        RealmService.save(items: parseData)
    }
}
