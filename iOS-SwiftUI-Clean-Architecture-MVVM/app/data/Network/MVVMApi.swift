//
//  MVVMApi.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation

enum MVVMApi {
    // TODO check for other types
    static func getBaseUrl() -> URL {
        #if DEBUG
        return URL(string: "https://raw.githubusercontent.com/")!
        #elseif INHOUSE
        return URL(string: "https://raw.githubusercontent.com/")
        #elseif RELEASE
        return URL(string: "https://raw.githubusercontent.com/")
        #endif
    }
    
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "\(getBaseUrl())dinkar1708/APITest/master/apis/")!
}
