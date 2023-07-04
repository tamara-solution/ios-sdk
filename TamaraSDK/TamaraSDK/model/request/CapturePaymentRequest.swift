//
//  CapturePaymentRequest.swift
//  Runner
//
//  Created by Thien on 29/05/2023.
//

import Foundation

struct CapturePaymentRequest: Codable {
    var orderId: String? = ""
    var billingAddress: Address? = nil
    var discountAmount: Amount? = nil
    var items: Array<Item>? = Array()
    var shippingAddress: Address? = nil
    var shippingAmount: Amount? = nil
    var taxAmount: Amount? = nil
    var totalAmount: Amount? = nil
    var shippingInfo: ShippingInfo? = nil
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case billingAddress = "billing_address"
        case discountAmount = "discount_amount"
        case items
        case shippingAddress = "shipping_address"
        case shippingAmount = "shipping_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case shippingInfo = "shipping_info"
    }
    
    init(jsonData: Data) throws{
        let decoder = JSONDecoder()
        self = try decoder.decode(CapturePaymentRequest.self, from: jsonData)
    }
    
    func convertToJson() throws -> String {
        let jsonData = try JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
