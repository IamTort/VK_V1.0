// PhotoCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка c фотографией
final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var likeContainerControl: LikeControl!

    // MARK: - Public methods

    func setupData(data: String) {
        photoImageView.image = UIImage(named: data)
    }
}
