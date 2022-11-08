// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class LoginViewController: UIViewController {
    // MARK: - Private Enum

    private enum Constants {
        static let segueIdentifier = "loginVC"
        static let loginText = "a"
        static let passwordText = "1"
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Логин и/или пароль неверны."
    }

    // MARK: - IBOutlet

    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var scrollView: UIScrollView!

    @IBOutlet private var firstDotImageView: UIImageView!
    @IBOutlet private var secondDotImageView: UIImageView!
    @IBOutlet private var thirdDotImageView: UIImageView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        setupUIDots()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }

    // MARK: - Public method

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.segueIdentifier,
              checkLoginInfo()
        else {
            showLoginError(title: Constants.alertTitleText, message: Constants.alertMessageText)
            return false
        }
        animateDots()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
        }
        return false
    }

    // MARK: - Private methods

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as? NSDictionary,
              let kbSize = (
                  info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)
                      as? NSValue
              )?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom:
            kbSize.height,
            right: 0.0
        )
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    private func setupUIDots() {
        firstDotImageView.layer.cornerRadius = 10
        secondDotImageView.layer.cornerRadius = 10
        thirdDotImageView.layer.cornerRadius = 10
    }

    private func animateDots() {
        UIImageView.animate(
            withDuration: 1.2,
            delay: 0,
            options: [.autoreverse, .repeat]
        ) {
            self.firstDotImageView.alpha = 1
        }

        UIImageView.animate(
            withDuration: 1.2,
            delay: 0.9,
            options: [.autoreverse, .repeat]
        ) {
            self.secondDotImageView.alpha = 1
        }

        UIImageView.animate(
            withDuration: 1.2,
            delay: 1.9,
            options: [.autoreverse, .repeat]
        ) {
            self.thirdDotImageView.alpha = 1
        }
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector:
            #selector(keyboardWillShownAction(notification:)),
            name:
            UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector:
            #selector(keyboardWillHideAction(notification:)),
            name:
            UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func checkLoginInfo() -> Bool {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login == Constants.loginText,
              password == Constants.passwordText else { return false }
        return true
    }
}
