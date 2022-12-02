// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран список доступных групп
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "availableGroupCell"
        static let errorTitleString = "Ошибка"
        static let errorDescriptionString = "Ошибка загрузки данных с сервера"
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

        cell.setup(group: filteredGroups[indexPath.row], networkService: networkService)
        return cell
    }

    // MARK: - Private methods

    private func loadAvailableGroups(text: String) {
        networkService.fetchAvailableGroups(searchText: text) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case let .success(result):
                self.filteredGroups = result.response.items
                self.tableView.reloadData()
            case .failure:
                self.showErrorAlert(title: Constants.errorTitleString, message: Constants.errorDescriptionString)
            }
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
