//
//  MockData.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/30.
//

import Foundation

extension ItemModel {
    static func getHomeMockData() -> [Self] {
        return [
            Self(id: "1", name: "Google Pixel 4", image: "", price: 90000),
            Self(id: "2", name: "iPhone 15 Pro", image: "", price: 45000),
            Self(id: "3", name: "Xiaomi Redmi Note", image: "", price: 35000),
            Self(id: "4", name: "Samsung Galaxy S24", image: "", price: 75000),
            Self(id: "5", name: "OnePlus 12", image: "", price: 65000),
        ]
    }
}
