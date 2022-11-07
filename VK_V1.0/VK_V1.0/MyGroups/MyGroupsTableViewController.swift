// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Мои группы
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "groupCell"
        static let segueIdentifier = "addGroupSegue"
        static let mygroups = [Group(imageName: "built", title: "Cтроить весело")]
    }

    // MARK: - Private property

    private var mygroups = Constants.mygroups

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mygroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? MyGroupsTableViewCell else { return UITableViewCell() }
        cell.setup(group: mygroups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        mygroups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Private IBAction

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueIdentifier,
              let availableGroupController = segue.source as? AvailableGroupsTableViewController,
              let indexPath = availableGroupController.tableView.indexPathForSelectedRow,
              !mygroups.contains(where: { $0.title == availableGroupController.availableGroups[indexPath.row].title })
        else { return }

        mygroups.append(availableGroupController.availableGroups[indexPath.row])
        tableView.reloadData()
    }
}
