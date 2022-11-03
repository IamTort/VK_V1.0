// MyGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка моей группы
final class MyGroupsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var titleGroupLabel: UILabel!

    // MARK: - Public method

    func setup(data: Group) {
        avatarImageView.image = UIImage(named: data.image)
        titleGroupLabel.text = data.title
    }
}
