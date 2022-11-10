// cloudView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Облако
final class CloudView: UIView {
    // MARK: - Private IBOutlet

    @IBOutlet private var cloudView: UIView!
    @IBOutlet private var backView: UIView!

    // MARK: - Private property

    private let cloudLayer = CAShapeLayer()
    private let backLayer = CAShapeLayer()
    private let bezierPath = UIBezierPath()

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureBezierPath()
        configureLayers()
        configureAnimation()
        displayCloudView()
    }

    // MARK: - Private methods

    private func configureBezierPath() {
        bezierPath.move(to: CGPoint(x: 56.5, y: 61.5))
        bezierPath.addCurve(
            to: CGPoint(x: 97.5, y: 61.5),
            controlPoint1: CGPoint(x: 55.5, y: 61.5),
            controlPoint2: CGPoint(x: 97.5, y: 61.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 105.5, y: 53.5),
            controlPoint1: CGPoint(x: 97.5, y: 61.5),
            controlPoint2: CGPoint(x: 110.5, y: 60.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 94.5, y: 49.5),
            controlPoint1: CGPoint(x: 100.5, y: 46.5),
            controlPoint2: CGPoint(x: 94.5, y: 49.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 94.5, y: 42.5),
            controlPoint1: CGPoint(x: 92.5, y: 49.5),
            controlPoint2: CGPoint(x: 101.5, y: 46.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 86.5, y: 42.5),
            controlPoint1: CGPoint(x: 87.5, y: 38.5),
            controlPoint2: CGPoint(x: 86.5, y: 42.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 76.5, y: 33.5),
            controlPoint1: CGPoint(x: 87.5, y: 43.5),
            controlPoint2: CGPoint(x: 82.5, y: 30.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 69.5, y: 42.5),
            controlPoint1: CGPoint(x: 70.5, y: 36.5),
            controlPoint2: CGPoint(x: 69.5, y: 42.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 56.5, y: 42.5),
            controlPoint1: CGPoint(x: 68.5, y: 43.5),
            controlPoint2: CGPoint(x: 59.5, y: 35.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 56.5, y: 53.5),
            controlPoint1: CGPoint(x: 53.5, y: 49.5),
            controlPoint2: CGPoint(x: 56.5, y: 53.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 47.5, y: 57.5),
            controlPoint1: CGPoint(x: 56.5, y: 55.5),
            controlPoint2: CGPoint(x: 47.5, y: 53.5)
        )
        bezierPath.addCurve(
            to: CGPoint(x: 56.5, y: 61.5),
            controlPoint1: CGPoint(x: 47.5, y: 61.5),
            controlPoint2: CGPoint(x: 55.5, y: 61.5)
        )
        bezierPath.close()
    }

    private func displayCloudView() {
        cloudView.transform = CGAffineTransform(scaleX: 2, y: 2)
        cloudView.layer.bounds.origin.x = -130
        cloudView.layer.bounds.origin.y = -150
    }

    private func configureLayers() {
        cloudLayer.path = bezierPath.cgPath
        cloudLayer.lineWidth = 3
        cloudLayer.strokeColor = UIColor.blue.cgColor
        cloudLayer.fillColor = UIColor.clear.cgColor
        cloudView.layer.addSublayer(cloudLayer)

        backLayer.path = bezierPath.cgPath
        backLayer.lineWidth = 4
        backLayer.strokeColor = UIColor.gray.cgColor
        backLayer.fillColor = UIColor.white.cgColor
        backView.layer.addSublayer(backLayer)
    }

    private func configureAnimation() {
        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: .linear)

        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1.5

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = 4
        animationGroup.repeatCount = .infinity
        cloudLayer.add(animationGroup, forKey: nil)
    }
}
