//
//  CancelOrder.swift
//  Runner
//
//  Created by Thien on 30/05/2023.
//

import Foundation

struct CancelOrder: Codable {
    var discountAmount: Amount?
    var items: Array<Item>?
    var shippingAmount: Amount?
    var taxAmount: Amount?
    var totalAmount: Amount?
    
    enum CodingKeys: String, CodingKey {
        case discountAmount = "discount_amount"
        case items
        case shippingAmount = "shipping_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
    }
    
    init(jsonData: Data) throws {
        let decoder = JSONDecoder()
        self = try! decoder.decode(CancelOrder.self, from: jsonData)
    }
    
    public init(
        discountAmount: Amount?,
        items: Array<Item>?,
        shippingAmount: Amount?,
        taxAmount: Amount?,
        totalAmount: Amount
    ) {
        self.discountAmount = discountAmount
        self.items = items
        self.shippingAmount = shippingAmount
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
