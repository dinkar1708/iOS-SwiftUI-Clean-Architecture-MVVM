//
//  APIClient.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation
import Foundation
import Combine

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        print("APIClient API path \(String(describing: request.url))")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                print("APIClient API response in string form")
                print(String(data: result.data, encoding: .utf8)!)
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
