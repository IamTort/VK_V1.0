// Date+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension Date {
    var toRusString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
