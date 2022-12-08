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
        guard let likes = news.likes?.count,
              let views = news.views?.count else { return }
        likeControl.setupData(data: likes)
        viewsCountLabel.text = String(views)
    }
}
