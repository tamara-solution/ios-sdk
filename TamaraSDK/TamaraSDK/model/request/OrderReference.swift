//
//  OrderReference.swift
//  Runner
//
//  Created by Thien on 30/05/2023.
//

import Foundation

struct OrderReference: Codable {
    var orderReferenceId: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case orderReferenceId = "order_reference_id"
    }
    
    public init(
        orderReferenceId: String?
    ) {
        self.orderReferenceId = orderReferenceId
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
