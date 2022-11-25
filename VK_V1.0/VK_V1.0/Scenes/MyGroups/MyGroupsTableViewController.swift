// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Мои группы
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "groupCell"
        static let segueIdentifier = "addGroupSegue"
    }

    // MARK: - Private property

    private let networkService = NetworkService()
    private var groups: [Group] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyGroups()
    }

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? MyGroupsTableViewCell else { return UITableViewCell() }
        cell.setup(group: groups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        groups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Private IBAction

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueIdentifier,
              let availableGroupController = segue.source as? AvailableGroupsTableViewController,
              let indexPath = availableGroupController.tableView.indexPathForSelectedRow,
              !groups.contains(where: { $0.name == availableGroupController.filteredGroups[indexPath.row].name })
        else { return }

        groups.append(availableGroupController.filteredGroups[indexPath.row])
        tableView.reloadData()
    }

    // MARK: - Private methods

    private func loadMyGroups() {
        networkService.fetchMyGroups(completion: { [weak self] result in
            guard let self = self else { return }
            self.groups = result.response.items
            self.tableView.reloadData()
        })
    }
}
