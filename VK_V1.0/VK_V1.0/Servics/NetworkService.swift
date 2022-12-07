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
        static let newsfeedGetMethod = "/method/newsfeed.get"
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
        static let filtersName = "filters"
        static let filtersValue = "post"
        static let responseName = "response"
        static let itemsName = "items"
        static let profilesName = "profiles"
        static let groupsName = "groups"
    }

    // MARK: - Public methods

    func fetchFriends(completion: @escaping (Result<ResponseUser, Error>) -> ()) {
        guard let id = SessionInformation.shared.userId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.userIdName: "\(id)",
            Constants.versionName: Constants.versionValue,
            Constants.fieldsName: Constants.fieldsValue
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.friendMethod, paramsMap: params)
        else { return }
        requestData(url: url, completion: completion)
    }

    func fetchPhotos(for ownerId: Int?, completion: @escaping (Result<ResponsePhoto, Error>) -> Void) {
        guard let ownerId = ownerId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.versionName: Constants.versionValue,
            Constants.extendedName: Constants.extendedValue,
            Constants.ownerIdName: "\(ownerId)"
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.photosMethod, paramsMap: params)
        else { return }
        requestData(url: url, completion: completion)
    }

    func fetchMyGroups(completion: @escaping (Result<ResponseGroup, Error>) -> ()) {
        guard let id = SessionInformation.shared.userId,
              let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.userIdName: "\(id)",
            Constants.versionName: Constants.versionValue,
            Constants.extendedName: Constants.extendedValue
        ]
        guard let url: URL = .configureURL(token: token, typeMethod: Constants.myGroupsMethod, paramsMap: params)
        else { return }
        requestData(url: url, completion: completion)
    }

    func fetchAvailableGroups(searchText: String?, completion: @escaping (Result<ResponseGroup, Error>) -> Void) {
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
        requestData(url: url, completion: completion)
    }

    func fetchNewsfeed(completion: @escaping (ResponseNewsfeed) -> Void) {
        guard let token = SessionInformation.shared.token else { return }
        let params = [
            Constants.versionName: Constants.versionValue,
            Constants.filtersName: Constants.filtersValue
        ]

        guard let url: URL = .configureURL(token: token, typeMethod: Constants.newsfeedGetMethod, paramsMap: params)
        else { return }
        AF.request(url).responseData { [self] response in
            guard let value = response.value else { return }
            parse(data: value, completionHandler: completion)
        }
    }

    func loadImage(iconUrl: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: iconUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }

    // MARK: - Private methods

    private func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url).responseData { response in
            guard let value = response.value else { return }
            do {
                let model = try JSONDecoder().decode(T.self, from: value)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func asyncParse<Model: Decodable>(data: Data, group: DispatchGroup, completion: @escaping (Model) -> Void) {
        DispatchQueue.global().async {
            if let parsedModel = try? JSONDecoder().decode(Model.self, from: data) {
                completion(parsedModel)
            }
            group.leave()
        }
    }

    private func parse(data: Data, completionHandler: @escaping (ResponseNewsfeed) -> Void) {
        DispatchQueue.global().async {
            var parsedItems: [Newsfeed] = []
            var parsedProfiles: [NewsProfile] = []
            var parsedGroups: [NewsGroup] = []

            let json = (
                try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    as? [String: Any]
            ) ?? [:]
            let response = (json[Constants.responseName] as? [String: Any]) ?? [:]

            let items = response[Constants.itemsName]
            let profiles = response[Constants.profilesName]
            let groups = response[Constants.groupsName]

            let itemsData = (try? JSONSerialization.data(withJSONObject: items as Any, options: .fragmentsAllowed))
                ?? Data()
            let profilesData = (try? JSONSerialization.data(
                withJSONObject: profiles as Any,
                options: .fragmentsAllowed
            )) ?? Data()
            let groupsData = (try? JSONSerialization.data(withJSONObject: groups as Any, options: .fragmentsAllowed))
                ?? Data()

            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            dispatchGroup.enter()
            dispatchGroup.enter()

            self.asyncParse(data: itemsData, group: dispatchGroup) { (model: [Newsfeed]) in
                parsedItems = model
            }
            self.asyncParse(data: profilesData, group: dispatchGroup) { (model: [NewsProfile]) in
                parsedProfiles = model
            }
            self.asyncParse(data: groupsData, group: dispatchGroup) { (model: [NewsGroup]) in
                parsedGroups = model
            }

            dispatchGroup.notify(queue: .global()) {
                let news = ResponseNewsfeed(response: ItemsNewsfeed(
                    items: parsedItems,
                    profiles: parsedProfiles,
                    groups: parsedGroups
                ))
                completionHandler(news)
            }
        }
    }
}
