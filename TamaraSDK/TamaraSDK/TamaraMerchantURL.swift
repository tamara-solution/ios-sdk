//
//  TamaraMerchantURL.swift
//  TamaraSDK
//
//  Created by Admin on 10/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

// MARK: - TamaraMerchantURL
public struct TamaraMerchantURL: Codable {
    var success, failure, cancel, notification: String
    
    public init(
        success: String,
        failure: String,
        cancel: String,
        notification: String
    ) {
        self.success = success
        self.failure = failure
        self.cancel = cancel
        self.notification = notification
    }
}
