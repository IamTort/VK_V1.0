// CustomPopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Анимация скрытия экрана
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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
        transitionContext.containerView.sendSubviewToBack(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) {
            source.view.setAnchorPoint(CGPoint(x: 1, y: 0))
            source.view.transform = CGAffineTransform(rotationAngle: 80)
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
