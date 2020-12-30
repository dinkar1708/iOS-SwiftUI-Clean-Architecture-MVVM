//
//  AmazonHomeViewModel.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation
import Combine

final class AmazonHomeViewModel : ObservableObject{
    @Published private(set) var state: State
    var cancellationToken: AnyCancellable?

    init() {
        state = .loading
        print("loading......")
    }

    func fetchHomeContent() {
        self.cancellationToken = MVVMApi.getHomeData()
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

extension AmazonHomeViewModel {
    enum State {
        case loading
        case loaded([AmazonHome])
        case error(String)
    }
}
