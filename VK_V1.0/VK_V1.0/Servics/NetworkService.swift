// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Загрузка данных с сервера
final class NetworkService {
    // MARK: - Constants

    private enum Constants {
        static let friendMethod = "/method/friends.get"
        static let photosMethod = "/method/photos.getAll"
        static let myGroupsMethod = "/method/groups.get"
        static let availableGroupsMethod = "/method/groups.search"
        static let userIdName = "user_id"
        static let versionName = "v"
        static let versionValue = "5.131"
        static let fieldsName = "fields"
        static let extendedName = "extended"
        static let extendedValue = "1"
        static let searchTextName = "q"
        static let fieldsValue = "first_name, photo_50"
        static let ownerIdName = "owner_id"
        static let countGroupsName = "count"
        static let countGroupsValue = "40"
    }

    // MARK: - Public methods

    func fetchFriends(completion: @escaping (ResponseUser) -> Void) {
        guard let id = SessionInformation.shared.userId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.userIdName: "\(id)",
            Constants.versionName: Constants.versionValue,
            Constants.fieldsName: Constants.fieldsValue
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.friendMethod, paramsMap: params)
        else { return }
        requestUrl(url: url, completion: completion)
    }

    func fetchPhotos(for ownerId: Int?, completion: @escaping (ResponsePhoto) -> Void) {
        guard let ownerId = ownerId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.versionName: Constants.versionValue,
            Constants.extendedName: Constants.extendedValue,
            Constants.ownerIdName: "\(ownerId)"
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.photosMethod, paramsMap: params)
        else { return }
        requestUrl(url: url, completion: completion)
    }

    func fetchMyGroups(completion: @escaping (ResponseGroup) -> Void) {
        guard let id = SessionInformation.shared.userId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.userIdName: "\(id)",
            Constants.versionName: Constants.versionValue,
            Constants.extendedName: Constants.extendedValue
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.myGroupsMethod, paramsMap: params)
        else { return }
        requestUrl(url: url, completion: completion)
    }

    func fetchAvailableGroups(searchText: String?, completion: @escaping (ResponseGroup) -> Void) {
        guard let text = searchText,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.searchTextName: text,
            Constants.versionName: Constants.versionValue,
            Constants.countGroupsName: Constants.countGroupsValue,
            Constants.fieldsName: Constants.fieldsValue
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.availableGroupsMethod, paramsMap: params)
        else { return }
        requestUrl(url: url, completion: completion)
    }

    // MARK: - Private methods

    private func requestUrl<T: Decodable>(url: URL, completion: @escaping (T) -> Void) {
        AF.request(url).responseData { response in
            guard let value = response.value else { return }
            do {
                let model = try JSONDecoder().decode(T.self, from: value)
                completion(model)
            } catch {
                fatalError()
            }
        }
    }
}
