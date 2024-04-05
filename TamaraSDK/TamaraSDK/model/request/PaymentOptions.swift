//
//  PaymentOptions.swift
//  TamaraSDK
//
//  Created by phong on 1/4/24.
//

import Foundation
struct PaymentOptions: Codable {
    var country: String? = nil
    var orderValue: Amount? = nil
    var phoneNumber: String? = nil
    var isVip: Bool? = nil

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case orderValue = "order_value"
        case phoneNumber = "phone_number"
        case isVip = "is_vip"
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(PaymentOptions.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
