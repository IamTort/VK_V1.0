// PushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация открытия экрана
final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private property

    private let animationDuration: TimeInterval = 1

    // MARK: - Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -90)

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) {
            source.view.setAnchorPoint(CGPoint(x: 0, y: 0))
            source.view.transform = CGAffineTransform(rotationAngle: -80)
            destination.view.transform = CGAffineTransform(rotationAngle: 80)
            destination.view.transform = .identity

        } completion: { finished in
            guard finished, !transitionContext.transitionWasCancelled else {
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                return
            }
            source.view.transform = .identity
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
