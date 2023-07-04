//
//  MerchantUrl.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

public struct MerchantUrl : Codable {
    var notification: String = "tamara://checkout/notification" // https://example.com/payments/tamarapay
    var cancel: String = "tamara://checkout/cancel" // https://example.com/checkout/cancel
    var failure: String = "tamara://checkout/failure" // https://example.com/checkout/failure
    var success: String = "tamara://checkout/success" // https://example.com/checkout/success
    
    enum CodingKeys: String, CodingKey {
        case notification
        case cancel
        case failure
        case success
    }
    
    public init(
        notification: String
//        cancel: String,
//        failure: String,
//        success: String
    ) {
        self.notification = notification
//        self.cancel = cancel
//        self.failure = failure
//        self.success = success
    }
}
