// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран входа
final class AuthorizationViewController: UIViewController {
    // MARK: - Private enum

    private enum Constants {
        static let path = "/authorize"
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let queryItems = [
            URLQueryItem(name: "client_id", value: "8181012"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, groups, photos, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: "Hello"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        static let segueIdentifier = "showFriends"
        static let accessTokenName = "access_token"
        static let userIdName = "user_id"
        static let wkWebViewPath = "/blank.html"
        static let ampersand = "&"
        static let equals = "="
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            self.webView.navigationDelegate = self
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAuth()
    }

    // MARK: - Private methods

    private func loadAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.queryItems = Constants.queryItems

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        print(request)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url,
              url.path == Constants.wkWebViewPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: Constants.ampersand)
            .map { $0.components(separatedBy: Constants.equals) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params[Constants.accessTokenName],
              let userId = params[Constants.userIdName] else { return }
        SessionInformation.instance.token = token
        SessionInformation.instance.userId = Int(userId)
        print(token)
        print(userId)
        decisionHandler(.cancel)
        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
    }
}
