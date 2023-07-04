//
//  RefundsResponse.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct RefundsResponse: Codable {
    let order_id: String?
    let comment: String?
    let refund_id: String?
    let capture_id: String?
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(RefundsResponse.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
