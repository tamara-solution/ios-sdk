//
//  CheckoutSession.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct CheckoutSession: Codable {
    let checkout_url: String?
    let order_id: String?
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(CheckoutSession.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
