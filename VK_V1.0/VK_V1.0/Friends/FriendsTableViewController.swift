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
            User(image: "cat", name: "Marcus Volfgan", photos: ["cat", "car", "bear"]),
            User(image: nil, name: "Aarcus Volfgan", photos: ["cat", "car", "bear"]),
            User(image: "cat", name: "Tarcus Volfgan", photos: ["cat", "car", "bear"]),
            User(image: "cat", name: "Ahdurcus Volfgan", photos: ["cat", "car", "bear"]),
            User(image: nil, name: "Krcus Volfgan", photos: ["cat", "car", "bear"])
        ]
    }

    // MARK: - Private property

    private var friends = Constants.friends
    private var sortedFriends = [Character: [User]]()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        sortFriends()
    }

    // MARK: - Public methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keysSorted[section]]?.count ?? 0
        return friends
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? FriendsTableViewCell,
            let friends = sortedFriends[firstChar] else { return UITableViewCell() }

        let friend = friends[indexPath.row]
        cell.setupData(data: friend)
        return cell
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriends.keys.sorted()[section])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let destination = segue.destination as? PhotoCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        destination.user = friends[indexPath.row]
    }

    // MARK: - Private methods

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
        sortedFriends = sort(friends: friends)
    }
}
