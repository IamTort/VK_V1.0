// AvailableGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка доступной группы
final class AvailableGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - Public methods

    func setup(group: Group) {
        guard let url = URL(string: group.imageUrl) else { return }
        avatarImageView.loadImage(url: url)
        titleLabel.text = group.name
    }
}
