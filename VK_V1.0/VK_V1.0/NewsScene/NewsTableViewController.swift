// NewsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с новостями
final class NewsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let cellIdentifier = "newsCell"
        static let news = [
            News(
                avatarName: "cat",
                name: "Marcus Volfgan",
                time: "15.09.2022",
                description: """
                            Когда так много позади всего,
                            в особенности — горя,
                            поддержки чьей-нибудь не жди,
                            сядь в поезд,
                            высадись у моря.
                """,
                photoName: "car",
                likeCount: 346,
                viewsCount: 2984
            ),
            News(
                avatarName: "car",
                name: "Marcus Volfgan",
                time: "15.01.2022",
                description:
                "Стоишь на берегу и чувствуешь солёный запах ветра, что веет с моря." +
                    " И веришь, что свободен ты, и жизнь лишь началась.",
                photoName: "bear",
                likeCount: 456,
                viewsCount: 584
            ),
            News(
                avatarName: "man",
                name: "Marcus Volfgan",
                time: "12.03.2022",
                description: """
                            Приехать к морю в несезон,
                            помимо материальных выгод,
                            имеет тот еще резон,
                            что это — временный, но выход.
                """,
                photoName: "cat",
                likeCount: 45,
                viewsCount: 4
            ),
            News(
                avatarName: "cat",
                name: "Marcus Volfgan",
                time: "05.09.2022",
                description:
                nil,
                photoName: "car",
                likeCount: 456,
                viewsCount: 584
            )
        ]
    }

    // MARK: - Private IBOutlet
    
    @IBOutlet private weak var searchBar: UISearchBar!
    // MARK: - Private property

    private let news = Constants.news

    // MARK: - Public methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
            as? NewsTableViewCell else { return UITableViewCell() }
        cell.setup(news: news[indexPath.row])
        return cell
    }
}
