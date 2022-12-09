// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Экран Мои группы
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "groupCell"
        static let segueIdentifier = "addGroupSegue"
        static let errorTitleString = "Ошибка"
        static let errorDescriptionString = "Ошибка загрузки данных с сервера"
    }

    // MARK: - Private property

    private let networkService = NetworkService()
    private let dataProvider = DataProvider()
    private var notificationToken: NotificationToken?
    private var groups: Results<Group>?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyGroups()
    }

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? MyGroupsTableViewCell,
            let group = groups?[indexPath.row] else { return UITableViewCell() }
        cell.setup(group: group, networkService: networkService)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard let group = groups?[indexPath.row],
              editingStyle == .delete else { return }
        dataProvider.deleteGroup(group)
        tableView.reloadData()
    }

    // MARK: - Private methods

    private func loadMyGroups() {
        networkService.getGroups()
        fetchGroups()
    }

    private func fetchGroups() {
        guard let group = dataProvider.loadData(items: Group.self) else { return }
        createNotificationToken(group)
        groups = group
    }

    private func createNotificationToken(_ groups: Results<Group>) {
        notificationToken = groups.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial:
                break
            case .update:
                self.tableView.reloadData()
            case let .error(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: error.localizedDescription)
            }
        }
    }
}
