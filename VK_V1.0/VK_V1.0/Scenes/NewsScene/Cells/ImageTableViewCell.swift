// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка картинки новости
final class ImageTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public methods

    func configure(news: Newsfeed, networkService: NetworkService) {
        guard let avatar = news.avatarUrl else { return }
        photoImageView.loadImage(with: avatar, networkService: networkService)
    }
}
