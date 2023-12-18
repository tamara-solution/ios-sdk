//
//  RiskAssessment.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct RiskAssessment: Codable {
    let customerAge: Int
    let customerDob, customerGender, customerNationality: String
    let isPremiumCustomer, isExistingCustomer, isGuestUser: Bool
    let accountCreationDate, platformAccountCreationDate, dateOfFirstTransaction: String
    let isCardOnFile, isCODCustomer, hasDeliveredOrder, isPhoneVerified: Bool
    let isFraudulentCustomer: Bool
    let totalLtv: Double
    let totalOrderCount: Int
    let orderAmountLast3Months: Double
    let orderCountLast3Months: Int
    let lastOrderDate: String
    let lastOrderAmount: Double
    let rewardProgramEnrolled: Bool
    let rewardProgramPoints: Int

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
