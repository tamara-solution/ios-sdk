//
//  CancelOrderResponse.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation
public struct CancelOrderResponse: Codable {
    var cancelId: String? = ""
    var orderId: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case cancelId = "cancel_id"
        case orderId = "order_id"
    }
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(CancelOrderResponse.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
