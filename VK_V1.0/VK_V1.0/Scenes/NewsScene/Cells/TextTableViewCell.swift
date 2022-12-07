// TextTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка текста новости
final class TextTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var descriptionLabel: UILabel!

    // MARK: - Public methods

    func configure(news: Newsfeed) {
        descriptionLabel.text = news.text
    }
}
