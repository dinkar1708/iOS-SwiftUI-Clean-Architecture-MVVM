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
            Self(name: "pixel4", image: "image", price: 90000),
            Self(name: "iphone", image: "image", price: 45000),
            Self(name: "MI android phone", image: "image", price: 35000),
        ]
    }
}
