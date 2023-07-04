//
//  OrderDetail.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct OrderDetail: Codable {
    var billingAddress: Address? = nil
    var consumer: Consumer? = nil
    var countryCode: String? = "SA"
    var description: String? = "This is description"
    var status: String? = "This is description"
    var discountAmount: DiscountDetail? = nil
    var items: Array<Item>? = Array()
    var orderReferenceId: String? = ""
    var orderId: String? = ""
    var orderNumber: String? = ""
    var paymentType: String? = "PAY_BY_LATER"
    var shippingAddress: Address? = nil
    var shippingAmount: Amount? = nil
    var taxAmount: Amount? = nil
    var totalAmount: Amount? = nil
    var capturedAmount: Amount? = nil
    var refundedAmount: Amount? = nil
    var canceledAmount: Amount? = nil
    var paidAmount: Amount? = nil
    var walletPrepaidAmount: Amount? = nil
    var settlementStatus: String? = nil
    var settlementDate: String? = nil
    var createdAt: String? = nil
    var instalments: Int? = nil
    
    enum CodingKeys: String, CodingKey {
        case billingAddress = "billing_address"
        case consumer
        case countryCode = "country_code"
        case description
        case status
        case discountAmount = "discount_amount"
        case items
        case orderReferenceId = "order_reference_id"
        case orderId = "order_id"
        case orderNumber = "order_number"
        case paymentType = "payment_type"
        case shippingAddress = "shipping_address"
        case shippingAmount = "shipping_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case capturedAmount = "captured_amount"
        case refundedAmount = "refunded_amount"
        case canceledAmount = "canceled_amount"
        case paidAmount = "paid_amount"
        case walletPrepaidAmount = "wallet_prepaid_amount"
        case settlementStatus = "settlement_status"
        case settlementDate = "settlement_date"
        case createdAt = "created_at"
        case instalments
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(OrderDetail.self, from: jsonData)
    }
    
    public func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
