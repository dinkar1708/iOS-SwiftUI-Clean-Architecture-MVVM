//
//  MVVMApi.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation

enum MVVMApi {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://raw.githubusercontent.com/dinkar1708/APITest/master/apis/")!
}
