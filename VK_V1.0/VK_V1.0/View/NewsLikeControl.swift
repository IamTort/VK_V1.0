// NewsLikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Компонент анимированных лайков
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

    private var isLiked = false
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

    func setupData(data: Int) {
        likesCount = data
    }

    // MARK: - Private methods

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapAction(_: UITapGestureRecognizer) {
        isLiked.toggle()

        guard isLiked else {
            heartImageView.image = UIImage(systemName: Constants.heartImageName)
            countLikeLabel?.textColor = .systemGray
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
        countLikeLabel?.textColor = .red
        heartImageView.tintColor = .red
        likesCount += 1
    }
}
