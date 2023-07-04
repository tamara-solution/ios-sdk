//
//  CheckoutResponse.swift
//  TamaraSDK
//
//  Created by Chuong Dang on 4/23/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

struct TamaraCheckoutResponse: Codable {
    var orderId: String?
    var checkoutUrl: String
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case checkoutUrl = "checkout_url"
    }
}
