//
//  Address.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct Address : Codable {
    var firstName, lastName, line1, line2, region, city, countryCode, phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case line1
        case line2
        case region
        case city
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
