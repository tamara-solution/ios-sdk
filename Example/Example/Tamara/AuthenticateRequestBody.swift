//
//  AuthenticateRequestBody.swift
//  TamaraSDK
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

struct TamaraAuthenticateRequestBody: Codable {
    var email: String
    var password: String
}
