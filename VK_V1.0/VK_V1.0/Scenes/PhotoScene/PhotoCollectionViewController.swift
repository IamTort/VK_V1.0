// PhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

///  Экран фотографии друга
final class PhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "photoCell"
        static let segueIdentifier = "swipeSceneSegue"
        static let photoType = "z"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Public property

    var user: User?

    // MARK: - Private property

    private let networkService = NetworkService()
    private let realmService = RealmService()
    private var photos: Results<Photo>?
    private var imageUrlsString: [String] = []
    private lazy var photoCacheService = PhotoCacheService(self.collectionView)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        fetchPhotos()
    }

    // MARK: - Public methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageUrlsString.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.setupData(
            photoName: imageUrlsString[indexPath.item],
            photoCacheService: photoCacheService
        )
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let destination = segue.destination as? SwipePhotoViewController,
              let cell = sender as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }
        destination.photosUrls = imageUrlsString
        destination.swipe = indexPath.row
    }

    // MARK: - Private methods

    private func fetchPhotos() {
        networkService.fetchPhotos(for: user?.id) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case let .success(results):
                RealmService.save(items: results.response.items, update: false)
                self.photos = self.realmService.loadData(items: Photo.self)
                self.imageUrlsString = self.sortImage(type: Constants.photoType, array: results.response.items)
                self.collectionView.reloadData()
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: error.localizedDescription)
            }
        }
    }

    private func sortImage(type: String, array: [Photo]) -> [String] {
        var links: [String] = []

        for image in array {
            for size in image.sizes {
                guard size.type == type else { continue }
                links.append(size.url)
            }
        }
        return links
    }

    private func setupTitle() {
        navigationItem.title = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
    }
}
