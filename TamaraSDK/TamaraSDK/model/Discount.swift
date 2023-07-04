//
//  Discount.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct Discount : Codable {
    var amount: Amount
    var name: String = "" // Christmas 2020
    
    enum CodingKeys: String, CodingKey {
        case amount
        case name
    }
    
    public init(
        amount: Amount,
        name: String
    ) {
        self.amount = amount
        self.name = name
    }
}
