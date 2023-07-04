//
//  Item.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct Item : Codable {
    var name: String // Lego City 8601
    var referenceId: String = "" // 123456
    var sku: String = "" // SA-12436
    var type: String = "" // SA-12436
    var unitPrice: Amount? = nil
    var quantity: Int? = 0 // 1
    var discountAmount: Amount? = nil
    var taxAmount: Amount? = nil
    var totalAmount: Amount? = nil
    var imageUrl: String? = ""
    var itemUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case referenceId = "reference_id"
        case sku
        case type
        case unitPrice = "unit_price"
        case quantity
        case discountAmount = "discount_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case imageUrl = "image_url"
        case itemUrl = "item_url"
    }
    
    public init(
        name: String,
        referenceId: String,
        sku: String,
        type: String,
        unitPrice: Amount,
        quantity: Int,
        discountAmount: Amount,
        taxAmount: Amount,
        totalAmount: Amount
    ) {
        self.name = name
        self.referenceId = referenceId
        self.sku = sku
        self.type = type
        self.unitPrice = unitPrice
        self.quantity = quantity
        self.discountAmount = discountAmount
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
    }
}
