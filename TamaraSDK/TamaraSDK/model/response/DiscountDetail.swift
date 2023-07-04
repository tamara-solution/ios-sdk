//
//  DiscountDetail.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct DiscountDetail: Codable {
    var amount: Amount? = nil
    var name: String? = ""
    
    init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(DiscountDetail.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
