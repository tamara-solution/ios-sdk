//
//  InvalidState.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/8/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

struct InvalidState: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorMessage: String? {
        message
    }
}
