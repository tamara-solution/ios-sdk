//
//  AvailablePayment.swift
//  TamaraSDK
//
//  Created by phong on 1/4/24.
//

import Foundation
public struct AvailablePayment: Codable {
    var payment_type: String? = nil
    var description: String? = nil
    var description_ar: String? = nil
    var instalment: Int? = 0
   
    public init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(AvailablePayment.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
