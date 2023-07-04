//
//  PaymentRefund.swift
//  Runner
//
//  Created by Thien on 27/05/2023.
//

import Foundation

struct PaymentRefund: Codable {
    var comment: String? = ""
    var totalAmount: Amount? = nil
    
    enum CodingKeys: String, CodingKey {
        case comment = "comment"
        case totalAmount = "total_amount"
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(PaymentRefund.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
