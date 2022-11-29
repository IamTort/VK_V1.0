// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// загрузка картинки
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil) {
        image = nil
        let networkService = NetworkService()
        let iconUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        networkService.loadImage(iconUrl: iconUrl) { data in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                self.image = image
            }
        }
    }
}
