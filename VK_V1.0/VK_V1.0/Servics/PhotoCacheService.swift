// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Сервис для скачивания и кеширования фото
final class PhotoCacheService {
    // MARK: - Private Constants

    private enum Constants {
        static let pathName = "images"
        static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
        static let slash: Character = "/"
    }

    // MARK: - Private properties

    private static let pathName: String = {
        let pathName = Constants.pathName
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    private let container: DataReloadable
    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime
    private var imagesMap = [String: UIImage]()

    // MARK: - Initializers

    init(container: UITableView) {
        self.container = Table(container)
    }

    init(container: UICollectionView) {
        self.container = Collection(container)
    }

    // MARK: - Public Methods

    func getPhoto(byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = imagesMap[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(byUrl: url)
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
              let hashName = url.split(separator: Constants.slash).last else { return nil }
        return cachesDirectory.appendingPathComponent("\(PhotoCacheService.pathName)\(Constants.slash)\(hashName)").path
    }

    private func loadPhoto(byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { response in
            guard let data = response.data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imagesMap[url] = image
                self.saveImageToCache(url: url, image: image)
                self.container.reloadData()
            }
        }
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.imagesMap[url] = image
        }
        return image
    }
}

// MARK: - Extention PhotoCacheService

extension PhotoCacheService {
    private class Collection: DataReloadable {
        // MARK: - Private Properties

        private let collection: UICollectionView

        // MARK: - Initializers

        init(_ collection: UICollectionView) {
            self.collection = collection
        }

        // MARK: - Public Methods

        func reloadData() {
            collection.reloadData()
        }
    }

    private class Table: DataReloadable {
        private let table: UITableView

        init(_ table: UITableView) {
            self.table = table
        }

        func reloadData() {
            table.reloadData()
        }
    }
}
