// LikeControl.swift

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
    private var touches = 0 {
        didSet {
            countLikeLabel.text = "\(touches)"
        }
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        createGestureRecognizer()
    }

    // MARK: - Private methods

    private func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }

    @objc func handleTapAction(_: UITapGestureRecognizer) {
        isLike.toggle()

        guard isLike else {
            heartImageView.image = UIImage(systemName: Constants.heartImageName)
            countLikeLabel.textColor = .black
            heartImageView.tintColor = .black
            touches -= 1
            return
        }
        heartImageView.image = UIImage(systemName: Constants.fillHeartImageName)
        countLikeLabel.textColor = .red
        heartImageView.tintColor = .red
        touches += 1
    }
}
