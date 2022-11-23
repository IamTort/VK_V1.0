// AvailableGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран список доступных групп
final class AvailableGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "availableGroupCell"
        static let availableGroups = [
            Group(imageName: "built", title: "Cтроить вес"),
            Group(imageName: "bear", title: "Музыка"),
            Group(imageName: "cat", title: "Коты - цветы жизни"),
            Group(imageName: "built", title: "Cтроить дом"),
            Group(imageName: "man", title: "Молодые мужчины")
        ]
        static let searchText = "nature"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Public property

    let availableGroups = Constants.availableGroups

    // MARK: - Private property

    private let networkService = NetworkService()
    private var filteredGroups: [Group] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFilteredGroups()
        loadAvailableGroups()
    }

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

    private func loadAvailableGroups() {
        networkService.fetchAvailableGroups(searchText: Constants.searchText)
    }

    private func updateFilteredGroups() {
        filteredGroups = availableGroups
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = searchText.isEmpty ? availableGroups : availableGroups.filter { $0.title.contains(searchText) }
        tableView.reloadData()
    }
}
