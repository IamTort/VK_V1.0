// ImageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Ячейка картинки новости
final class ImageTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public methods

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }

    func configure(news: Newsfeed, photoCacheService: PhotoCacheService) {
        guard let photo = news.attachments?.first?.photo?.sizes.last?.url else { return }
        photoImageView.image = photoCacheService.getPhoto(byUrl: photo)
    }
}
