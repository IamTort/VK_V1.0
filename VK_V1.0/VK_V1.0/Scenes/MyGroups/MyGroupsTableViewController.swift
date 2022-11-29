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
    }

    // MARK: - Private property

    private let networkService = NetworkService()
    private var notificationToken: NotificationToken?
    private var groups: Results<Group>?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyGroups()
        loadGroupsFromRealm()
    }

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? MyGroupsTableViewCell else { return UITableViewCell() }
        guard let group = groups?[indexPath.row] else { return UITableViewCell() }
        cell.setup(group: group)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard let group = groups?[indexPath.row],
              editingStyle == .delete else { return }
        deleteGroup(group)
        tableView.reloadData()
    }

    // MARK: - Private methods

    private func loadMyGroups() {
        networkService.fetchMyGroups()
        loadGroupsFromRealm()
    }

    private func loadGroupsFromRealm() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.groups = groups
            createNotificationToken()
        } catch {
            print(error)
        }
    }

    private func createNotificationToken() {
        notificationToken = groups?.observe { [weak self] result in
            switch result {
            case .initial:
                break
            case .update:
                self?.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func deleteGroup(_ group: Group) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error)
        }
    }
}
