// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран Друзья
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "friendCell"
        static let segueIdentifier = "photoSegue"
    }

    // MARK: - Private property

    private let networkService = NetworkService()
    private var sortedFriendsMap = [Character: [User]]()
    private var users: [User] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
    }

    // MARK: - Public methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriendsMap.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedFriendsMap.keys.sorted()
        let friends = sortedFriendsMap[keysSorted[section]]?.count ?? 0
        return friends
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstChar = sortedFriendsMap.keys.sorted()[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? FriendsTableViewCell,
            let friends = sortedFriendsMap[firstChar] else { return UITableViewCell() }

        let friend = friends[indexPath.row]
        cell.setupData(data: friend)
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureHeaderView(section: section)
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriendsMap.keys.sorted()[section])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let destination = segue.destination as? PhotoCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.user = getOneUser(indexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        3
    }

    // MARK: - Private methods

    private func loadFriends() {
        networkService.fetchFriends(completion: { [weak self] result in
            guard let self = self else { return }
            self.users = result.response.items
            self.sortFriends()
            self.tableView.reloadData()
        })
    }

    private func configureHeaderView(section index: Int) -> UIView {
        let headerView = FriendsHeaderView()
        headerView.configureText(text: String(sortedFriendsMap.keys.sorted()[index]))
        return headerView
    }

    private func sort(friends: [User]) -> [Character: [User]] {
        var friendsDict = [Character: [User]]()
        friends.forEach { friend in

            guard let firstChar = friend.firstName.first else { return }

            if var thisCharFriend = friendsDict[firstChar] {
                thisCharFriend.append(friend)
                friendsDict[firstChar] = thisCharFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
        }
        return friendsDict
    }

    private func getOneUser(indexPath: IndexPath) -> User? {
        let firstChar = sortedFriendsMap.keys.sorted()[indexPath.section]
        guard let users = sortedFriendsMap[firstChar] else { return nil }
        let user = users[indexPath.row]
        return user
    }

    private func sortFriends() {
        sortedFriendsMap = sort(friends: users)
    }
}
