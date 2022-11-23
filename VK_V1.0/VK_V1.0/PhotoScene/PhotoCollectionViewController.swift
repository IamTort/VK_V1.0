// PhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран фотографии друга
final class PhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "photoCell"
        static let userId = "4470702"
    }

    // MARK: - Public property

    var user: User?

    // MARK: - Private property

    private let service = NetworkService()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        service.loadData(data: .photos, for: Constants.userId, searchText: nil)
    }

    // MARK: - Public methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user?.photos.count ?? 0
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? PhotoCollectionViewCell,
            let photo = user?.photos[indexPath.row] else { return UICollectionViewCell() }
        cell.setupData(data: photo)
        return cell
    }

    // MARK: - Private methods

    private func setupTitle() {
        navigationItem.title = user?.name
    }
}
