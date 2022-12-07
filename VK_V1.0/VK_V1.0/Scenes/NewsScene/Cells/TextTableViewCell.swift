// TextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка текста новости
final class TextTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var descriptionLabel: UILabel!

    // MARK: - Public methods

    func configure(newsText: String) {
        descriptionLabel.text = newsText
    }
}
