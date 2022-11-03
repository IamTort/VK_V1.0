// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран список доступных групп
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "availableGroupCell"
        static let availableGroups = [
            Group(image: "built", title: "Cтроить вес"),
            Group(image: "bear", title: "Музыка"),
            Group(image: "cat", title: "Коты - цветы жизни"),
            Group(image: "built", title: "Cтроить дом"),
            Group(image: "man", title: "Молодые мужчины")
        ]
    }

    // MARK: - Public property

    let availableGroups = Constants.availableGroups

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        availableGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? AvailableGroupsTableViewCell else { return UITableViewCell() }
        cell.setup(data: availableGroups[indexPath.row])
        return cell
    }
}
