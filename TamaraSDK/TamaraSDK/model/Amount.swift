//
//  Amount.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct Amount : Codable {
    var amount: Double = 0.0 // 50.00
    var currency: String? = "" // SAR
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
    }
    
    public init(
        amount: Double,
        currency: String
    ) {
        self.amount = amount
        self.currency = currency
    }
}
