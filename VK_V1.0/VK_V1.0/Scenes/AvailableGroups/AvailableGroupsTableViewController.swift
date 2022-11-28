// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран список доступных групп
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "availableGroupCell"
        static let searchText = "nature"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Public property

    var filteredGroups: [Group] = []

    // MARK: - Private property

    private let networkService = NetworkService()

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? AvailableGroupsTableViewCell else { return UITableViewCell() }

        cell.setup(group: filteredGroups[indexPath.row])
        return cell
    }

    // MARK: - Private methods

    private func loadAvailableGroups(text: String) {
        networkService.fetchAvailableGroups(searchText: text) { [weak self] result in
            guard let self = self else { return }
            self.filteredGroups = result.response.items
            self.tableView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups.removeAll()
        guard !searchText.isEmpty else {
            tableView.reloadData()
            return
        }
        loadAvailableGroups(text: searchText)
    }
}
