//
//  MVVMApi.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation
import Combine

extension MVVMApi {
    static func getMyOrders() -> AnyPublisher<[ItemModel], Error> {
        let myOrdersApiName = "/items.json"
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(myOrdersApiName), resolvingAgainstBaseURL: true)
        else { fatalError("URLComponents can not be created!") }
        return apiClient.run(URLRequest(url: components.url!))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
