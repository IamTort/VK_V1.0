// FriendsPromiseNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit

/// Сервис для получения данных друзей
final class FriendsPromiseNetworkService {
    // MARK: - Constants

    private enum Constants {
        static let friendMethod = "/method/friends.get"
        static let userIdName = "user_id"
        static let versionName = "v"
        static let versionValue = "5.131"
        static let fieldsName = "fields"
        static let fieldsValue = "first_name, photo_50"
    }

    // MARK: - Public Methods

    func fetchFriends() -> Promise<[User]> {
        let promise = Promise<[User]> { resolver in
            guard let id = SessionInformation.shared.userId,
                  let token = SessionInformation.shared.token else { return }
            let params = [
                Constants.userIdName: "\(id)",
                Constants.versionName: Constants.versionValue,
                Constants.fieldsName: Constants.fieldsValue
            ]
            guard let url: URL = .configureURL(
                token: token,
                typeMethod: Constants.friendMethod,
                paramsMap: params
            ) else { return }
            AF.request(url).responseData { response in
                guard let value = response.value else { return }
                do {
                    let model = try JSONDecoder().decode(ResponseUser.self, from: value).response.items
                    resolver.fulfill(model)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
