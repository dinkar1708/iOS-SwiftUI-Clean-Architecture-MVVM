//
//  AmazonHomeViewModel.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation
import Combine

final class MyOrdersViewModel : ObservableObject{
    @Published private(set) var state: State
    var cancellationToken: AnyCancellable?

    init() {
        state = .loading
        print("loading......")
    }

    func fetchHomeContent() {
        self.cancellationToken = MVVMApi.getMyOrders()
            .mapError({ (er) -> Error in
                self.state = .error(er.localizedDescription)
                return er
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.state = .loaded($0)
                    print("loaded......")
                  })
    }
}

extension MyOrdersViewModel {
    enum State {
        case loading
        case loaded([ItemModel])
        case error(String)
    }
}
