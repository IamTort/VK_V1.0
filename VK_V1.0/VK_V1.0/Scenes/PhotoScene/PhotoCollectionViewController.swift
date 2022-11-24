// PhotoCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Экран фотографии друга
final class PhotoCollectionViewController: UICollectionViewController {
    // MARK: - Private enum

    private enum Constants {
        static let cellIdentifier = "photoCell"
        static let segueIdentifier = "swipeSceneSegue"
        static let photoType = "z"
    }

    // MARK: - Public property

    var user: User?

    // MARK: - Private property

    private let networkService = NetworkService()
    private var storedModels: [Photo]?
    private var storedImages: [String] = []

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        fetchPhotos()
    }

    // MARK: - Public methods

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storedImages.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        cell.setupData(data: storedImages[indexPath.item])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueIdentifier,
              let destination = segue.destination as? SwipePhotoViewController,
              let cell = sender as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }
        destination.photosUrls = storedImages
        destination.swipe = indexPath.row
    }

    // MARK: - Private methods

    private func fetchPhotos() {
        networkService.fetchPhotos(for: user?.id) { [weak self] result in
            self?.storedModels = result.response.items
            guard let imagesLinks = self?.sortImage(type: Constants.photoType, array: result.response.items)
            else { return }
            self?.storedImages = imagesLinks
            self?.collectionView.reloadData()
        }
    }

    private func sortImage(type: String, array: [Photo]) -> [String] {
        var links: [String] = []

        for model in array {
            for size in model.sizes {
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
