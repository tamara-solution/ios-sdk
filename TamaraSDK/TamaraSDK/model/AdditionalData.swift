//
//  AdditionalData.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation
 
public struct AdditionalData: Codable {
    let deliveryMethod, pickupStore, storeCode: String
    let vendorInfo: [VendorInfo]

    enum CodingKeys: String, CodingKey {
        case deliveryMethod = "delivery_method"
        case pickupStore = "pickup_store"
        case storeCode = "store_code"
        case vendorInfo = "vendor_info"
    }

    public init(
        deliveryMethod: String,
        pickupStore: String,
        storeCode: String,
        vendorInfo: [VendorInfo]
    ) {
        self.deliveryMethod = deliveryMethod
        self.pickupStore = pickupStore
        self.storeCode = storeCode
        self.vendorInfo = vendorInfo
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(AdditionalData.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
