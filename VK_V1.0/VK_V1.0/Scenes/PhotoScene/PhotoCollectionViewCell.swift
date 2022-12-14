// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка c фотографией
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public methods

    func setupData(photoName: String, photoCacheService: PhotoCacheService) {
//        let indexPath = IndexPath(row: index, section: 0)
        photoImageView.image = photoCacheService.getPhoto(byUrl: photoName)
    }
}
