// CloudViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран загрузки с облаком
final class CloudViewController: UIViewController {
    // MARK: - Private enum

    private enum Constants {
        static let loginViewControllerID = "LoginViewController"
        static let storyboardName = "Main"
    }

    // MARK: - LifeCycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withDuration: 2)
    }

    // MARK: - Private Methods

    private func performSegue(withDuration: UInt32) {
        sleep(withDuration)
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.loginViewControllerID)
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
}
