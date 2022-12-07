// LikeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка лайков новости
final class LikeTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet private var viewsCount: UILabel!
    @IBOutlet private var likeControl: NewsLikeControl!

    // MARK: - Public methods

    func configure(news: Newsfeed) {
        likeControl.setupData(data: news.likes.count)
        viewsCount.text = String(news.views.count)
    }
}
