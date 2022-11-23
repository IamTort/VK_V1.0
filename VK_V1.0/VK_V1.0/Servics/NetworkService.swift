// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Глобальный список типов данных
enum TypeMethod {
    case friends
    case photos
    case myGroups
    case availableGroups
}

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

    func loadData(data: TypeMethod, for ownerId: String?, searchText: String?) {
        guard let id = SessionInformation.instance.userId,
              let token = SessionInformation.instance.token else { return }

        var url: URL?

        switch data {
        case .friends:
            let params = [
                Constants.userIdName: "\(id)",
                Constants.versionName: Constants.versionValue,
                Constants.fieldsName: Constants.fieldsValue
            ]
            url = .configureURL(token: token, typeMethod: Constants.friendMethod, paramsMap: params)

        case .photos:
            guard let ownerId = ownerId else { return }
            let params = [
                Constants.versionName: Constants.versionValue,
                Constants.extendedName: Constants.extendedValue,
                Constants.ownerIdName: "\(ownerId)"
            ]
            url = .configureURL(token: token, typeMethod: Constants.photosMethod, paramsMap: params)

        case .myGroups:
            let params = [
                Constants.userIdName: "\(id)",
                Constants.versionName: Constants.versionValue,
                Constants.extendedName: Constants.extendedValue
            ]
            url = .configureURL(token: token, typeMethod: Constants.myGroupsMethod, paramsMap: params)

        case .availableGroups:
            guard let text = searchText else { return }
            let params = [
                Constants.searchTextName: text,
                Constants.versionName: Constants.versionValue,
                Constants.countGroupsName: Constants.countGroupsValue,
                Constants.fieldsName: Constants.fieldsValue
            ]
            url = .configureURL(token: token, typeMethod: Constants.availableGroupsMethod, paramsMap: params)
        }
        guard let url = url else { return }
        requestUrl(url: url)
    }

    // MARK: - Private methods

    private func requestUrl(url: URL) {
        AF.request(url).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
