// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка c фотографией
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public methods

    func setupData(atIndexpath indexPath: IndexPath, photoName: String, photoCacheService: PhotoCacheService) {
        photoImageView.image = photoCacheService.photo(atIndexpath: indexPath, byUrl: photoName)
    }
}
