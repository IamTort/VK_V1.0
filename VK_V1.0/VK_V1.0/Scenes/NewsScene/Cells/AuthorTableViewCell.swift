// AuthorTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка автора новости
final class AuthorTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        }
    }

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!

    // MARK: - Public methods

    func configure(news: Newsfeed, networkService: NetworkService) {
        guard let avatar = news.avatarUrl else { return }
        avatarImageView.loadImage(with: avatar, networkService: networkService)
        nameLabel.text = news.authorName
        timeLabel.text = createDate(date: news.date)
    }

    // MARK: - Private methods

    private func createDate(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
