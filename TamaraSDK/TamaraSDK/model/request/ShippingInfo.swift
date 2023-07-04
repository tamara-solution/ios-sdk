//
//  ShippingInfo.swift
//  Runner
//
//  Created by Thien on 29/05/2023.
//

import Foundation

struct ShippingInfo: Codable {
    var shippedAt: String? = ""
    var shippingCompany: String? = ""
    var trackingNumber: String? = ""
    var trackingUrl: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case shippedAt = "shipped_at"
        case shippingCompany = "shipping_company"
        case trackingNumber = "tracking_number"
        case trackingUrl = "tracking_url"
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(ShippingInfo.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
