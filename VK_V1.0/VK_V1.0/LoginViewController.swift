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
        static let actionOkText = "OK"
    }

    // MARK: - IBOutlet

    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var scrollView: UIScrollView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
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
        if identifier == Constants.segueIdentifier {
            if checkLoginInfo() {
                return true
            } else {
                showLoginError()
                return false
            }
        }
        return true
    }

    // MARK: - IBActions

    @IBAction private func unwindAction(_ sender: UIStoryboardSegue) {}

    // MARK: - Private methods

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
              let password = passwordTextField.text else { return false }
        if login == Constants.loginText, password == Constants.passwordText {
            return true
        } else {
            return false
        }
    }

    private func showLoginError() {
        let alertController = UIAlertController(
            title: Constants.alertTitleText,
            message:
            Constants.alertMessageText,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: Constants.actionOkText, style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

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
}
