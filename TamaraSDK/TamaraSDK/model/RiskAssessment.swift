//
//  RiskAssessment.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct RiskAssessment: Codable {
    var customerAge: Int? = nil
    var customerDob: String? = nil
    var customerGender: String? = nil
    var customerNationality: String? = nil
    var isPremiumCustomer: Bool? = nil
    var isExistingCustomer: Bool? = nil
    var isGuestUser: Bool? = nil
    var accountCreationDate: String? = nil
    var platformAccountCreationDate: String? = nil
    var dateOfFirstTransaction: String? = nil
    var isCardOnFile: Bool? = nil
    var isCODCustomer: Bool? = nil
    var hasDeliveredOrder: Bool? = nil
    var isPhoneVerified: Bool? = nil
    var isFraudulentCustomer: Bool? = nil
    var totalLtv: Double? = nil
    var totalOrderCount: Int? = nil
    var orderAmountLast3Months: Double? = nil
    var orderCountLast3Months: Int? = nil
    var lastOrderDate: String? = nil
    var lastOrderAmount: Double? = nil
    var rewardProgramEnrolled: Bool? = nil
    var rewardProgramPoints: Int? = nil

    enum CodingKeys: String, CodingKey {
        case customerAge = "customer_age"
        case customerDob = "customer_dob"
        case customerGender = "customer_gender"
        case customerNationality = "customer_nationality"
        case isPremiumCustomer = "is_premium_customer"
        case isExistingCustomer = "is_existing_customer"
        case isGuestUser = "is_guest_user"
        case accountCreationDate = "account_creation_date"
        case platformAccountCreationDate = "platform_account_creation_date"
        case dateOfFirstTransaction = "date_of_first_transaction"
        case isCardOnFile = "is_card_on_file"
        case isCODCustomer = "is_COD_customer"
        case hasDeliveredOrder = "has_delivered_order"
        case isPhoneVerified = "is_phone_verified"
        case isFraudulentCustomer = "is_fraudulent_customer"
        case totalLtv = "total_ltv"
        case totalOrderCount = "total_order_count"
        case orderAmountLast3Months = "order_amount_last3months"
        case orderCountLast3Months = "order_count_last3months"
        case lastOrderDate = "last_order_date"
        case lastOrderAmount = "last_order_amount"
        case rewardProgramEnrolled = "reward_program_enrolled"
        case rewardProgramPoints = "reward_program_points"
    }

    public init(
        customerAge: Int,
        customerDob: String,
        customerGender: String,
        customerNationality: String,
        isPremiumCustomer: Bool,
        isExistingCustomer: Bool,
        isGuestUser: Bool,
        accountCreationDate: String,
        platformAccountCreationDate: String,
        dateOfFirstTransaction: String,
        isCardOnFile: Bool,
        isCODCustomer: Bool,
        hasDeliveredOrder: Bool,
        isPhoneVerified: Bool,
        isFraudulentCustomer: Bool,
        totalLtv: Double,
        totalOrderCount: Int,
        orderAmountLast3Months: Double,
        orderCountLast3Months: Int,
        lastOrderDate: String,
        lastOrderAmount: Double,
        rewardProgramEnrolled: Bool,
        rewardProgramPoints: Int
    ) {
        self.customerAge = customerAge
        self.customerDob = customerDob
        self.customerGender = customerGender
        self.customerNationality = customerNationality
        self.isPremiumCustomer = isPremiumCustomer
        self.isExistingCustomer = isExistingCustomer
        self.isGuestUser = isGuestUser
        self.accountCreationDate = accountCreationDate
        self.platformAccountCreationDate = platformAccountCreationDate
        self.dateOfFirstTransaction = dateOfFirstTransaction
        self.isCardOnFile = isCardOnFile
        self.isCODCustomer = isCODCustomer
        self.hasDeliveredOrder = hasDeliveredOrder
        self.isPhoneVerified = isPhoneVerified
        self.isFraudulentCustomer = isFraudulentCustomer
        self.totalLtv = totalLtv
        self.totalOrderCount = totalOrderCount
        self.orderAmountLast3Months = orderAmountLast3Months
        self.orderCountLast3Months = orderCountLast3Months
        self.lastOrderDate = lastOrderDate
        self.lastOrderAmount = lastOrderAmount
        self.rewardProgramEnrolled = rewardProgramEnrolled
        self.rewardProgramPoints = rewardProgramPoints
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(RiskAssessment.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
