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
    var riskAssessment: Dictionary<String, Any> = [:]
    var additionalData: Dictionary<String, Any> = [:]

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
        riskAssessment: Dictionary<String, Any>?,
        additionalData: Dictionary<String, Any>?
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
        self.riskAssessment = riskAssessment ?? [:]
        self.additionalData = additionalData ?? [:]
    }

    public init(
        countryCode: String
    ) {
        self.countryCode = countryCode
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        billingAddress = try container.decodeIfPresent(Address.self, forKey: .billingAddress)
        consumer = try container.decodeIfPresent(Consumer.self, forKey: .consumer)
        countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode) ?? "SA"
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? "This is description"
        discount = try container.decodeIfPresent(Discount.self, forKey: .discount)
        items = try container.decodeIfPresent([Item].self, forKey: .items) ?? []
        locale = try container.decodeIfPresent(String.self, forKey: .locale) ?? "en-US"
        merchantUrl = try container.decodeIfPresent(MerchantUrl.self, forKey: .merchantUrl)
        orderReferenceId = try container.decodeIfPresent(String.self, forKey: .orderReferenceId) ?? ""
        paymentType = try container.decode(String.self, forKey: .paymentType)
        shippingAddress = try container.decodeIfPresent(Address.self, forKey: .shippingAddress)
        shippingAmount = try container.decodeIfPresent(Amount.self, forKey: .shippingAmount)
        taxAmount = try container.decodeIfPresent(Amount.self, forKey: .taxAmount)
        totalAmount = try container.decodeIfPresent(Amount.self, forKey: .totalAmount)
        platform = try container.decodeIfPresent(String.self, forKey: .platform)
        isMobile = try container.decodeIfPresent(Bool.self, forKey: .isMobile)
        instalments = try container.decodeIfPresent(Int.self, forKey: .instalments)
        orderNumber = try container.decodeIfPresent(String.self, forKey: .orderNumber)
        expiresInMinutes = try container.decodeIfPresent(Int.self, forKey: .expiresInMinutes)
        riskAssessment = try container.decode(Dictionary<String, Any>.self, forKey: .riskAssessment)
        additionalData = try container.decode(Dictionary<String, Any>.self, forKey: .additionalData)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(billingAddress, forKey: .billingAddress)
        try container.encode(consumer, forKey: .consumer)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(description, forKey: .description)
        try container.encode(discount, forKey: .discount)
        try container.encode(items, forKey: .items)
        try container.encode(locale, forKey: .locale)
        try container.encode(merchantUrl, forKey: .merchantUrl)
        try container.encode(orderReferenceId, forKey: .orderReferenceId)
        try container.encode(paymentType, forKey: .paymentType)
        try container.encode(shippingAddress, forKey: .shippingAddress)
        try container.encode(shippingAmount, forKey: .shippingAmount)
        try container.encode(taxAmount, forKey: .taxAmount)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(platform, forKey: .platform)
        try container.encode(isMobile, forKey: .isMobile)
        try container.encode(instalments, forKey: .instalments)
        try container.encode(orderNumber, forKey: .orderNumber)
        try container.encode(expiresInMinutes, forKey: .expiresInMinutes)
        try container.encode(riskAssessment, forKey: .riskAssessment)
        try container.encode(additionalData, forKey: .additionalData)
    }

    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
    
    mutating func updateAdditionalData(from jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                for (fieldName, jsonElement) in json {
                    additionalData[fieldName] = jsonElement
                }
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
    
    mutating func updateRiskAssessment(from jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                for (fieldName, jsonElement) in json {
                    riskAssessment[fieldName] = jsonElement
                }
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
}
