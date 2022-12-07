// LikeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка лайков новости
final class LikeTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var viewsCountLabel: UILabel!
    @IBOutlet private var likeControl: NewsLikeControl!

    // MARK: - Public methods

    func configure(news: Newsfeed) {
        likeControl.setupData(data: news.likes.count)
        viewsCountLabel.text = String(news.views.count)
    }
}
