// AvailableGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка доступной группы
final class AvailableGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - Public methods

    func setup(data: Group) {
        avatarImageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
    }
}
