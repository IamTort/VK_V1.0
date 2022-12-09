// FetchDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Асинхронная операция по загрузке данных
final class FetchDataOperation: AsyncOperation {
    // MARK: - Public property

    var data: Data?

    // MARK: - Private property

    private var request: DataRequest

    init(request: DataRequest) {
        self.request = request
    }

    // MARK: - Public methods

    override func cancel() {
        request.cancel()
        super.cancel()
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
