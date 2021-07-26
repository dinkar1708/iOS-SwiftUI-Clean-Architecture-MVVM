//
//  UserItem.swift
//  Shared
//
//  Created by Dinakar Maurya on 2021/07/26.
//

import Foundation

struct UserItem : Identifiable, Decodable {
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
