// NewsLikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Компонент для отображения количества лайков в ячейке Новости
final class NewsLikeControl: UIControl {
    // MARK: - Private enum

    private enum Constants {
        static let heartImageName = "suit.heart"
        static let fillHeartImageName = "suit.heart.fill"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var countLikeLabel: UILabel!
    @IBOutlet private var heartImageView: UIImageView!

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

    // MARK: - Public methods

    func setupData(data: News) {
        likesCount = data.likeCount
    }

    // MARK: - Private methods

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapAction(_: UITapGestureRecognizer) {
        isLike.toggle()

        guard isLike else {
            heartImageView.image = UIImage(systemName: Constants.heartImageName)
            countLikeLabel.textColor = .systemGray
            heartImageView.tintColor = .systemGray
            likesCount -= 1
            return
        }
        UIView.transition(
            with: heartImageView,
            duration: 1,
            options: .transitionFlipFromRight, animations: nil
        )
        heartImageView.image = UIImage(systemName: Constants.fillHeartImageName)
        countLikeLabel.textColor = .red
        heartImageView.tintColor = .red
        likesCount += 1
    }
}
