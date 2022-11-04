// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Компонент для отображения количества лайков
final class LikeControl: UIControl {
    // MARK: - Private enum

    private enum Constants {
        static let heartImageName = "suit.heart"
        static let fillHeartImageName = "suit.heart.fill"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var heartImageView: UIImageView!
    @IBOutlet private var countLikeLabel: UILabel!

    // MARK: - Private property

    private var isLike = false
    private var likesCount = 0 {
        didSet {
            countLikeLabel.text = "\(likesCount)"
        }
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        createGestureRecognizer()
    }

    // MARK: - Private methods

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func handleTapAction(_: UITapGestureRecognizer) {
        isLike.toggle()

        guard isLike else {
            heartImageView.image = UIImage(systemName: Constants.heartImageName)
            countLikeLabel.textColor = .black
            heartImageView.tintColor = .black
            likesCount -= 1
            return
        }
        heartImageView.image = UIImage(systemName: Constants.fillHeartImageName)
        countLikeLabel.textColor = .red
        heartImageView.tintColor = .red
        likesCount += 1
    }
}
