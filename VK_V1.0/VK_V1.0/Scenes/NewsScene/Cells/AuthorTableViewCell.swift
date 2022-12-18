// AuthorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка автора новости
final class AuthorTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        }
    }

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!

    // MARK: - Private properties

    private let dateFormatter = DateFormatter()

    // MARK: - Public methods

    func configure(news: Newsfeed, networkService: NetworkService) {
        guard let avatar = news.avatarUrl else { return }
        avatarImageView.loadImage(with: avatar, networkService: networkService)
        nameLabel.text = news.authorName
        timeLabel.text = dateFormatter.formatteDate(date: news.date)
    }
}
