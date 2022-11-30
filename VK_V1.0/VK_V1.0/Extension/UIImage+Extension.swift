// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// загрузка картинки
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil, networkService: NetworkService) {
        image = nil
        let iconUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        networkService.loadImage(iconUrl: iconUrl) { [weak self] data in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data),
                      let self = self else { return }
                self.image = image
            }
        }
    }
}
