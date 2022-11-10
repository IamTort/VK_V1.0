// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Кастомный контроллер навигации
final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    // MARK: - Private property

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    // MARK: - Public methods

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        return nil
    }
}
