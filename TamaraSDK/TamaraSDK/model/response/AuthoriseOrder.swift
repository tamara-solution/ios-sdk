//
//  AuthoriseOrder.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct AuthoriseOrder: Codable {
    let order_id: String?
    let status: String?
    let order_expiry_time: String?
    let payment_type: String?
//    let auto_captured: Bool?
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(AuthoriseOrder.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
