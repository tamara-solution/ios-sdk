//
//  Order.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

struct Order: Codable {
    var billingAddress: Address? = nil
    var consumer: Consumer? = nil
    var countryCode: String? = "SA"
    var description: String? = "This is description"
    var discount: Discount? = nil
    var items: Array<Item>? = Array()
    var locale: String? = "en-US"
    var merchantUrl: MerchantUrl? = nil
    var orderReferenceId: String? = "" // 123456
    var paymentType: String = "PAY_BY_INSTALMENTS" // PAY_BY_LATER
    var shippingAddress: Address? = nil
    var shippingAmount: Amount? = nil
    var taxAmount: Amount? = nil
    var totalAmount: Amount? = nil
    var platform: String? = nil
    var isMobile: Bool? = nil
    var instalments: Int? = nil
    var orderNumber: String? = nil
    var expiresInMinutes: Int? = nil
    var riskAssessment: RiskAssessment? = nil
    var additionalData: AdditionalData? = nil

    enum CodingKeys: String, CodingKey {
        case billingAddress = "billing_address"
        case consumer
        case countryCode = "country_code"
        case description
        case discount
        case items
        case locale
        case merchantUrl = "merchant_url"
        case orderReferenceId = "order_reference_id"
        case paymentType = "payment_type"
        case shippingAddress = "shipping_address"
        case shippingAmount = "shipping_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
        case platform
        case isMobile = "is_mobile"
        case instalments
        case orderNumber = "order_number"
        case expiresInMinutes = "expires_in_minutes"
        case riskAssessment = "risk_assessment"
        case additionalData = "additional_data"
    }

    public init(
        billingAddress: Address,
        consumer: Consumer,
        countryCode: String,
        description: String,
        discount: Discount,
        items: Array<Item>,
        locale: String,
        merchantUrl: MerchantUrl,
        orderReferenceId: String,
        paymentType: String,
        shippingAddress: Address,
        shippingAmount: Amount,
        taxAmount: Amount,
        totalAmount: Amount,
        platform: String,
        isMobile: Bool,
        instalments: Int,
        orderNumber: String,
        expiresInMinutes: Int,
        riskAssessment: RiskAssessment,
        additionalData: AdditionalData
    ) {
        self.billingAddress = billingAddress
        self.consumer = consumer
        self.countryCode = countryCode
        self.description = description
        self.discount = discount
        self.items = items
        self.locale = locale
        self.merchantUrl = merchantUrl
        self.orderReferenceId = orderReferenceId
        self.paymentType = paymentType
        self.shippingAddress = shippingAddress
        self.shippingAmount = shippingAmount
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
        self.platform = platform
        self.isMobile = isMobile
        self.instalments = instalments
        self.orderNumber = orderNumber
        self.expiresInMinutes = expiresInMinutes
        self.riskAssessment = riskAssessment
        self.additionalData = additionalData
    }

    public init(
        countryCode: String
    ) {
        self.countryCode = countryCode
    }

    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
