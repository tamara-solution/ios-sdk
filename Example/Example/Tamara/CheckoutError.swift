//
//  CheckoutError.swift
//  Example
//
//  Created by Admin on 3/5/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import Foundation

public struct TamaraCheckoutError: Codable {
    var message: String?
    var errors: [TamaraMassageError]?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case errors = "errors"
    }
    init(){}
}

struct TamaraMassageError: Codable {
    var error_code: String?
    
    enum CodingKeys: String, CodingKey {
        case error_code = "error_code"
    }
}
