//
//  ItemModel.swift
//  Shared
//
//  Created by Dinakar Maurya on 2021/07/26.
//

import Foundation

struct ItemModel: Identifiable, Decodable {
    let id: String
    let name: String
    let image: String
    let price: Float

    // Custom initializer for mock data
    init(id: String, name: String, image: String, price: Float) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
    }

    // Convenience initializer for backward compatibility
    init(id: Int, name: String, price: Float) {
        self.id = String(id)
        self.name = name
        self.image = ""
        self.price = price
    }
}
