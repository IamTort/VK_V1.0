// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Интерактивная анимация закрытия экрана
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public property

    var viewController: UIViewController? {
        didSet {
            let edgePanRecognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGesture(_:))
            )
            edgePanRecognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(edgePanRecognizer)
        }
    }

    var hasStarted: Bool = false

    // MARK: - Private property

    private var shouldFinish: Bool = false

    // MARK: - Private property

    @objc private func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.3
            update(progress)
        case .ended:
            hasStarted = false
            guard shouldFinish else { cancel()
                return
            }
            finish()
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
