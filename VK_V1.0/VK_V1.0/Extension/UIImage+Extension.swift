// UIImage+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// загрузка картинки
extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            guard
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
