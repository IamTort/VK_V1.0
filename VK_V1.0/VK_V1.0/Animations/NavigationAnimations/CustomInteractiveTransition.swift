// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивная анимация закрытия экрана
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public property

    var viewController: UIViewController? {
        didSet {
            let edgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGesture(_:))
            )
            edgePanGestureRecognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(edgePanGestureRecognizer)
        }
    }

    var isStarted: Bool = false

    // MARK: - Private property

    private var shouldFinish: Bool = false

    // MARK: - Private methods

    @objc private func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.3
            update(progress)
        case .ended:
            isStarted = false
            _ = shouldFinish ? finish() : cancel()
        case .cancelled:
            isStarted = false
            cancel()
        default: return
        }
    }
}
