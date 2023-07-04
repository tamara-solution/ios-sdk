//
//  WidgetProperties.swift
//  Runner
//
//  Created by Thien on 06/06/2023.
//

import Foundation

public struct WidgetProperties: Codable {
    var script: String? = ""
    var url: String? = ""
    
    public init(jsonData: Data) {
        let decoder = JSONDecoder()
        self = try! decoder.decode(WidgetProperties.self, from: jsonData)
    }
    
    func convertToJson() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}
