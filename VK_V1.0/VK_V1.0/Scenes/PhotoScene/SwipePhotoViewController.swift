// SwipePhotoViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран перелистывания фотографий
final class SwipePhotoViewController: UIViewController {
    // MARK: - Private enum

    private enum Side {
        case right
        case left
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public property

    var photosUrls: [String]?
    var swipe = 0

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        addSwipeGestureRecognizers()
    }

    // MARK: - Private methods

    private func configureImageView() {
        guard let image = photosUrls?[0] else { return }
        photoImageView.isUserInteractionEnabled = true
        photoImageView.loadImage(with: image)
    }

    private func addSwipeGestureRecognizers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction(sender:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        photoImageView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        photoImageView.addGestureRecognizer(swipeLeft)
    }

    private func photoEndAnimation(side: Side) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.2,
            options: .curveLinear
        ) { guard side == .right else { self.photoImageView.frame.origin.x = -30
            return
        }
        self.photoImageView.frame.origin.x = 30
        } completion: { _ in
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.4,
                options: .curveEaseInOut
            ) {
                self.photoImageView.frame.origin.x = .zero
            }
        }
    }

    @objc private func swipeGestureAction(sender: UISwipeGestureRecognizer?) {
        guard let photosUrls = photosUrls,
              let swipeGesture = sender else { return }
        switch swipeGesture.direction {
        case .right:
            guard swipe >= 1 else {
                photoEndAnimation(side: .right)
                return
            }
            swipe -= 1
            UIView.animateKeyframes(
                withDuration: 1,
                delay: 0.2,
                options: .calculationModeLinear
            ) {
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.photoImageView.alpha = 0
            } completion: { _ in
                self.photoImageView.alpha = 1
                self.photoImageView.frame.origin.x = .zero
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseIn
                ) {
                    self.photoImageView.frame.origin.x = self.view.bounds.width
                    self.photoImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.photoImageView.loadImage(with: photosUrls[self.swipe])
                }
            }
        case .left:
            guard swipe < photosUrls.count - 1 else {
                photoEndAnimation(side: .left)
                return
            }
            swipe += 1
            UIView.animateKeyframes(
                withDuration: 0.7,
                delay: 0,
                options: .beginFromCurrentState
            ) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                    self.photoImageView.frame.origin.x = -self.view.bounds.width
                }
                self.photoImageView.frame.origin.x = .zero
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } completion: { _ in
                self.photoImageView.loadImage(with: photosUrls[self.swipe])
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn) {
                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        default:
            break
        }
    }
}
