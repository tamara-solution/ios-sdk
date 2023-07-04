//
//  CheckoutStruct.swift
//  TamaraSDK
//
//  Created by Chuong Dang on 4/23/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation
import TamaraSDK

// MARK: - TamaraCheckoutRequestBody
public struct TamaraCheckoutRequestBody: Codable {
    var orderReferenceID: String
    var totalAmount: TamaraAmount
    var description, countryCode, paymentType, locale: String
    var items: [TamaraItem]
    var consumer: TamaraConsumer
    var billingAddress, shippingAddress: TamaraAddress
    var discount: TamaraDiscount?
    var taxAmount, shippingAmount: TamaraAmount
    var merchantURL: TamaraMerchantURL
    var platform: String
    var isMobile: Bool
    var riskAssessment: TamaraRiskAssessment?

    enum CodingKeys: String, CodingKey {
        case orderReferenceID = "order_reference_id"
        case totalAmount = "total_amount"
        case description = "description"
        case countryCode = "country_code"
        case paymentType = "payment_type"
        case locale, items, consumer
        case billingAddress = "billing_address"
        case shippingAddress = "shipping_address"
        case discount
        case taxAmount = "tax_amount"
        case shippingAmount = "shipping_amount"
        case merchantURL = "merchant_url"
        case platform
        case isMobile = "is_mobile"
        case riskAssessment = "risk_assessment"
    }

    public init(
        orderReferenceID: String,
        totalAmount: TamaraAmount,
        description: String,
        countryCode: String,
        paymentType: String,
        locale: String,
        items: [TamaraItem],
        consumer: TamaraConsumer,
        billingAddress: TamaraAddress,
        shippingAddress: TamaraAddress,
        discount: TamaraDiscount?,
        taxAmount: TamaraAmount,
        shippingAmount: TamaraAmount,
        merchantURL: TamaraMerchantURL,
        platform: String,
        isMobile: Bool,
        riskAssessment: TamaraRiskAssessment?
    ) {
        self.orderReferenceID = orderReferenceID
        self.totalAmount = totalAmount
        self.description = description
        self.countryCode = countryCode
        self.paymentType = paymentType
        self.locale = locale
        self.items = items
        self.consumer = consumer
        self.billingAddress = billingAddress
        self.shippingAddress = shippingAddress
        self.discount = discount
        self.taxAmount = taxAmount
        self.shippingAmount = shippingAmount
        self.merchantURL = merchantURL
        self.platform = platform
        self.isMobile = isMobile
        self .riskAssessment = riskAssessment
    }
}

// MARK: - TamaraAddress
public struct TamaraAddress: Codable {
    var firstName, lastName, line1, line2: String
    var region, city, countryCode, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case line1, line2, region, city
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
    }
    
    public init(
        firstName: String,
        lastName: String,
        line1: String,
        line2: String,
        region: String,
        city: String,
        countryCode: String,
        phoneNumber: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.line1 = line1
        self.line2 = line2
        self.region = region
        self.city = city
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
    }
}

// MARK: - TamaraConsumer
public struct TamaraConsumer: Codable {
    var firstName, lastName, phoneNumber, email, nationalID: String
    var dateOfBirth: String?
    var isFirstOrder: Bool? = false

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case email
        case nationalID = "national_id"
        case dateOfBirth = "date_of_birth"
        case isFirstOrder = "is_first_order"
    }
    
    public init(
        firstName: String,
        lastName: String,
        phoneNumber: String,
        email: String,
        nationalID: String,
        dateOfBirth: String?,
        isFirstOrder: Bool?
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.nationalID = nationalID
        self.dateOfBirth = dateOfBirth
        self.isFirstOrder = isFirstOrder
    }
}

// MARK: - TamaraDiscount
public struct TamaraDiscount: Codable {
    var name: String
    var amount: TamaraAmount
    
    public init(
        name: String,
        amount: TamaraAmount
    ) {
        self.name = name
        self.amount = amount
    }
}

public struct TamaraItem: Codable {
    var referenceID, type, name, sku: String
    var quantity: Int
    var unitPrice, discountAmount, taxAmount, totalAmount: TamaraAmount

    enum CodingKeys: String, CodingKey {
        case referenceID = "reference_id"
        case type, name, sku, quantity
        case unitPrice = "unit_price"
        case discountAmount = "discount_amount"
        case taxAmount = "tax_amount"
        case totalAmount = "total_amount"
    }
    
    public init(
        referenceID: String,
        type: String,
        name: String,
        sku: String,
        quantity: Int,
        unitPrice: TamaraAmount,
        discountAmount: TamaraAmount,
        taxAmount: TamaraAmount,
        totalAmount: TamaraAmount
    ) {
        self.referenceID = referenceID
        self.type = type
        self.name = name
        self.sku = sku
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.discountAmount = discountAmount
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
    }
}

// MARK: - TamaraRiskAssessment
public struct TamaraRiskAssessment: Codable {
    var hasCodFailed: Bool?

    enum CodingKeys: String, CodingKey {
        case hasCodFailed = "has_cod_failed"
    }
    
    public init(hasCodFailed: Bool?) {
        self.hasCodFailed = hasCodFailed
    }
}

// MARK: - TamaraAmount
public struct TamaraAmount: Codable {
    var amount: Double
    var currency: String
    
    public init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

