// NewsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка новости
final class NewsTableViewCell: UITableViewCell {
    @IBOutlet private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        }
    }

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var likeControl: NewsLikeControl!

    func setup(news: News) {
        avatarImageView.image = UIImage(named: news.avatarName)
        nameLabel.text = news.name
        timeLabel.text = news.time
        descriptionLabel.text = news.description
        photoImageView.image = UIImage(named: news.photoName)
        likeControl.setupData(data: news)
        viewsCountLabel.text = String(news.viewsCount)
    }
}
