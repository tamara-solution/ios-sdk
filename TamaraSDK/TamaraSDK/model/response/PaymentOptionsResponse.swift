//
//  PaymentOptionsResponse.swift
//  TamaraSDK
//
//  Created by phong on 1/4/24.
//

import Foundation
public struct PaymentOptionsResponse: Codable {
    var hasAvailablePaymentOptions: Bool? = false
    var singleCheckoutEnabled: Bool? = false
    var availablePaymentLabels: Array<AvailablePayment>? = Array()
    
    enum CodingKeys: String, CodingKey {
        case hasAvailablePaymentOptions = "has_available_payment_options"
        case singleCheckoutEnabled = "single_checkout_enabled"
        case availablePaymentLabels = "available_payment_labels"
    }
}
