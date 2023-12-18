//
//  VendorInfo.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct VendorInfo: Codable {
    let vendorAmount, merchantSettlementAmount: Int
    let vendorReferenceCode: String

    enum CodingKeys: String, CodingKey {
        case vendorAmount = "vendor_amount"
        case merchantSettlementAmount = "merchant_settlement_amount"
        case vendorReferenceCode = "vendor_reference_code"
    }

     public init(
        vendorAmount: Int,
        merchantSettlementAmount: Int,
        vendorReferenceCode: String
    ) {
        self.vendorAmount = vendorAmount
        self.merchantSettlementAmount = merchantSettlementAmount
        self.vendorReferenceCode = vendorReferenceCode
    }
}