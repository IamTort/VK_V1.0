// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка контроллера Друзей
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Private enum

    private enum Constants {
        static let avatarImageName = "avatar"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!

    // MARK: - Public methods

    func setupData(data: User) {
        nameLabel.text = data.name
        guard let image = data.image else {
            avatarImageView.image = UIImage(named: Constants.avatarImageName)
            return
        }
        avatarImageView.image = UIImage(named: image)
    }
}
