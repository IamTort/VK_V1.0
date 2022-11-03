// UIViewController+Extension.swift

import UIKit

/// Расширение для универсального алерта
extension UIViewController {
    private enum Constants {
        static let actionTitle = "ok"
    }

    func showLoginError(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message:
            message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: Constants.actionTitle, style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
