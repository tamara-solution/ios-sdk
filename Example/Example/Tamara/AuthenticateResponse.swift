//
//  AuthenticateResponse.swift
//  TamaraSDK
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

struct TamaraAuthenticateResponse: Codable {
    var token: String
    var expiredAt: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case expiredAt = "expired_at"
    }
}
