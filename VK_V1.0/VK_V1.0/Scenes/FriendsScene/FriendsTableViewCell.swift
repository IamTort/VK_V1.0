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

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
    }

    // MARK: - Public methods

    func setupData(data: User) {
        nameLabel.text = "\(data.firstName) \(data.lastName)"
        guard !data.photoUrl.isEmpty else {
            avatarImageView.image = UIImage(named: Constants.avatarImageName)
            return
        }
        avatarImageView.loadImage(with: data.photoUrl)
    }

    // MARK: - Private methods

    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
    }

    @objc private func handleTapAction() {
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
