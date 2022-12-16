// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let errorTitleString = "Ошибка"
        static let errorDescriptionString = "Ошибка загрузки данных с сервера"
        static let authorCellIdentifier = "authorCell"
        static let textCellIdentifier = "textCell"
        static let imageCellIdentifier = "imageCell"
        static let likeCellIdentifier = "likeCell"
        static let emptyString = ""
        static let loadText = "No news loaded. Pull screen to load data"
    }

    // MARK: - Types

    private enum CellType {
        case top
        case text
        case image
        case bottom
        case none
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private property

    private let networkService = NetworkService()
    private var photoCacheService: PhotoCacheService?
    private var indexOfCell: CellType = .none
    private var newsFeed: [Newsfeed] = []
    private var isLoading = false
    private var nextPage = Constants.emptyString

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Public methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        if newsFeed.isEmpty {
            tableView.showEmptyMessage(Constants.loadText)
        } else {
            tableView.hideEmptyMessage()
        }
        return newsFeed.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 4
        if newsFeed[section].text == nil { number -= 1 }
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !newsFeed.isEmpty else { return UITableViewCell() }
        let news = newsFeed[indexPath.section]
        setCellType(news, indexPath: indexPath)

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
            cell.configure(newsText: news.text ?? "")
            return cell
        case .image:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.imageCellIdentifier,
                for: indexPath
            ) as? ImageTableViewCell else { return UITableViewCell() }
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = newsFeed[indexPath.section]
        guard indexOfCell == .image,
              let photo = item.attachments?.first?.photo?.sizes.last else { return UITableView.automaticDimension }
        let tableWidth = tableView.bounds.width
        let cellHeight = tableWidth * photo.aspectRatio
        return cellHeight
    }

    // MARK: - Private methods

    private func configure() {
        fetchNewsfeed()
        setupRefreshControl()
        tableView.prefetchDataSource = self
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .gray
        refreshControl?.addTarget(self, action: #selector(refreshNewsAction), for: .valueChanged)
    }

    private func filterData(result: ResponseNewsfeed) {
        result.response.newsFeed.forEach { news in
            if news.sourceId < 0 {
                guard let group = result.response.groups.filter({ group in
                    group.id == news.sourceId * -1
                }).first else { return }
                news.authorName = group.name
                news.avatarUrl = group.photoUrlString
            } else {
                guard let user = result.response.users.filter({ user in
                    user.id == news.sourceId
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatarUrl = user.photoUrlString
            }
        }
    }

    private func fetchNewsfeed() {
        photoCacheService = PhotoCacheService(container: tableView)
        networkService.fetchNewsfeed { [weak self] results in
            guard let self = self else { return }
            self.nextPage = results.response.nextPage
            self.newsFeed = results.response.newsFeed
            self.filterData(result: results)
            self.tableView.reloadData()
        }
    }

    private func setCellType(_ news: Newsfeed, indexPath: IndexPath) {
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
    }

    private func fetchNewsNextPage() {
        networkService.fetchNewsfeed(nextPage: nextPage, startTime: nil) { [weak self] results in
            guard let self = self else { return }
            let oldNewsCount = self.newsFeed.count
            let newSections = (oldNewsCount ..< (oldNewsCount + results.response.newsFeed.count))
            self.nextPage = results.response.nextPage
            self.newsFeed += results.response.newsFeed
            self.filterData(result: results)
            self.tableView.insertSections(IndexSet(newSections), with: .automatic)
            self.isLoading = false
        }
    }

    @objc private func refreshNewsAction() {
        fetchNewsfeed()
        refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map(\.section).max(),
              maxRow > newsFeed.count - 3,
              isLoading == false else { return }
        isLoading = true
        fetchNewsNextPage()
    }
}
