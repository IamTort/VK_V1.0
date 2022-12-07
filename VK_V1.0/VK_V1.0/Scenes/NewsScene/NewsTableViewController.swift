// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Cell {
        case top
        case text
        case image
        case bottom
        case none
    }

    private enum Constants {
        static let errorTitleString = "Ошибка"
        static let errorDescriptionString = "Ошибка загрузки данных с сервера"
        static let authorCellIdentifier = "authorCell"
        static let textCellIdentifier = "textCell"
        static let imageCellIdentifier = "imageCell"
        static let likeCellIdentifier = "likeCell"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private property

    private let networkService = NetworkService()
    private var indexOfCell: Cell = .none
    private var newsFeed: [Newsfeed] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewsfeed()
    }

    // MARK: - Public methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        newsFeed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 4
        if newsFeed[section].text == nil { number -= 1 }
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !newsFeed.isEmpty else { return UITableViewCell() }
        let news = newsFeed[indexPath.section]
        switch indexPath.row {
        case 0:
            indexOfCell = .top
        case 1:
            indexOfCell = news.text == nil ? .image : .text
        case 2:
            indexOfCell = news.avatarUrl == nil || news.text == nil ? .bottom : .image
        case 3:
            indexOfCell = .bottom
        default:
            indexOfCell = .none
        }

        switch indexOfCell {
        case .top:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.authorCellIdentifier,
                for: indexPath
            ) as? AuthorTableViewCell else { return UITableViewCell() }

            cell.configure(news: newsFeed[indexPath.section], networkService: networkService)
            return cell
        case .text:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.textCellIdentifier, for: indexPath)
                as? TextTableViewCell else { return UITableViewCell() }
            cell.configure(news: news)
            return cell
        case .image:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.imageCellIdentifier,
                for: indexPath
            )
                as? ImageTableViewCell else { return UITableViewCell() }
            cell.configure(news: news, networkService: networkService)
            return cell
        case .bottom:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.likeCellIdentifier, for: indexPath)
                as? LikeTableViewCell else { return UITableViewCell() }
            cell.configure(news: news)
            return cell
        case .none:
            let cell = UITableViewCell()
            return cell
        }
    }

    // MARK: - Private  methods

    private func filterData(result: ResponseNewsfeed) {
        result.response.items.forEach { news in
            if news.sourceId < 0 {
                guard let group = result.response.groups.filter({ group in
                    group.id == news.sourceId * -1
                }).first else { return }
                news.authorName = group.name
                news.avatarUrl = group.photoUrl
            } else {
                guard let user = result.response.profiles.filter({ user in
                    user.id == news.sourceId
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatarUrl = user.photoUrl
            }
        }
    }

    private func loadNewsfeed() {
        networkService.fetchNewsfeed { [weak self] results in
            guard let self = self else { return }
            self.newsFeed = results.response.items
            self.filterData(result: results)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

//            switch results {
//            case let .success(result):
//                self.newsFeed = result.response.items
//                self.filterData(result: result)
//                self.tableView.reloadData()
//            case .failure:
//                self.showErrorAlert(title: Constants.errorTitleString, message: Constants.errorDescriptionString)
//            }
        }
    }
}
