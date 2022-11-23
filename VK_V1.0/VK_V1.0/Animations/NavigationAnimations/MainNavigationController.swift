// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Контроллер навигации
final class MainNavigationController: UINavigationController, UINavigationControllerDelegate {
    // MARK: - Private property

    private let interactiveTransition = CustomInteractiveTransition()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }

    // MARK: - Public methods

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            guard navigationController.viewControllers.first != toVC else {
                return PopAnimator()
            }
            interactiveTransition.viewController = toVC
            return PopAnimator()
        case .push:
            interactiveTransition.viewController = toVC
            return PushAnimator()
        default:
            return nil
        }
    }

    // MARK: - Private methods

    private func setupDelegate() {
        delegate = self
    }
}
