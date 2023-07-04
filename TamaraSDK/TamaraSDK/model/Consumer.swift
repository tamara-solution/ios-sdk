//
//  Consumer.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct Consumer : Codable {
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var dateOfBirth: String?
    var email: String
    var isFirstOrder: Bool?
    var nationalId: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case email
        case isFirstOrder = "is_first_order"
        case dateOfBirth = "date_of_birth"
        case nationalId = "national_id"
    }
    
    public init(
        firstName: String,
        lastName: String,
        phoneNumber: String,
        email: String,
        isFirstOrder: Bool
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.isFirstOrder = isFirstOrder
    }
}
