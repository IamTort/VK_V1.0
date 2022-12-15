// UITableView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сообщение при пустой таблице
extension UITableView {
    private enum Constants {
        static let fontSizeNumber: CGFloat = 25
    }

    func showEmptyMessage(_ message: String) {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: Constants.fontSizeNumber, weight: .semibold)
        label.text = message
        backgroundView = label
    }

    func hideEmptyMessage() {
        backgroundView = nil
    }
}
