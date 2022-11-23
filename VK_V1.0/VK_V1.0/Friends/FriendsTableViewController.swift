// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран Друзья
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "friendCell"
        static let segueIdentifier = "photoSegue"
        static let friends = [
            User(imageName: "cat", name: "Marcus Volfgan", photos: ["cat", "car", "bear"]),
            User(imageName: nil, name: "Ahdurcus Volfgan", photos: ["cat", "car", "bear"]),
            User(imageName: "cat", name: "Tarcus Volfgan", photos: ["cat", "car", "bear"]),
            User(imageName: "cat", name: "Arrcus Volfgan", photos: ["cat", "car", "bear"]),
            User(imageName: nil, name: "Krcus Volfgan", photos: ["cat", "car", "bear"])
        ]
    }

    // MARK: - Private property

    private let service = NetworkService()
    private let friends = Constants.friends
    private var sortedFriendsDict = [Character: [User]]()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        sortFriends()
        service.loadData(data: .friends, for: nil, searchText: nil)
    }

    // MARK: - Public methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriendsDict.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedFriendsDict.keys.sorted()
        let friends = sortedFriendsDict[keysSorted[section]]?.count ?? 0
        return friends
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstChar = sortedFriendsDict.keys.sorted()[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? FriendsTableViewCell,
            let friends = sortedFriendsDict[firstChar] else { return UITableViewCell() }

        let friend = friends[indexPath.row]
        cell.setupData(data: friend)
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureHeaderView(section: section)
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriendsDict.keys.sorted()[section])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let destination = segue.destination as? PhotoCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }

        destination.user = friends[indexPath.row]
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        3
    }

    // MARK: - Private methods

    private func configureHeaderView(section index: Int) -> UIView {
        let headerView = FriendsHeaderView()
        headerView.configureText(text: String(sortedFriendsDict.keys.sorted()[index]))
        return headerView
    }

    private func sort(friends: [User]) -> [Character: [User]] {
        var friendsDict = [Character: [User]]()
        friends.forEach { friend in

            guard let firstChar = friend.name.first else { return }

            if var thisCharFriend = friendsDict[firstChar] {
                thisCharFriend.append(friend)
                friendsDict[firstChar] = thisCharFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
        }
        return friendsDict
    }

    private func sortFriends() {
        sortedFriendsDict = sort(friends: friends)
    }
}
