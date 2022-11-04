// MyGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка моей группы
final class MyGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var titleGroupLabel: UILabel!

    // MARK: - Public method

    func setup(group: Group) {
        avatarImageView.image = UIImage(named: group.imageName)
        titleGroupLabel.text = group.title
    }
}
