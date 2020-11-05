//
//  CartItem.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    var name: String
    var sku: String
    var price: Double
    var tax: Double
    var quantity: Int
    var total: Double {
        return price * Double(quantity)
    }
}
