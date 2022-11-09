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

    @IBOutlet private var containerView: UIView! {
        didSet {
            isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
            containerView.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!

    // MARK: - Public methods

    func setupData(data: User) {
        nameLabel.text = data.name
        guard let image = data.imageName else {
            avatarImageView.image = UIImage(named: Constants.avatarImageName)
            return
        }
        avatarImageView.image = UIImage(named: image)
    }

    // MARK: - Private methods

    @objc private func handleTapAction(_: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1,
            options: .curveEaseInOut
        ) {
            self.avatarImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        avatarImageView.transform = .identity
    }
}
