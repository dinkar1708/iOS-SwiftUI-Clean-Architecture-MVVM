//
//  AmazonHome.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/29.
//

import Foundation

struct AmazonHome : Identifiable, Decodable {
    let id = UUID()
    let name : String!
    let image : String!
    let price : Float!

    init(name: String, image : String, price : Float) {
        self.name = name
        self.image = image
        self.price = price
    }
}
