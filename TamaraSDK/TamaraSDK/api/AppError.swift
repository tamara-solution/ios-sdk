//
//  AppError.swift
//  tamara_sdk
//
//  Created by MAC on 21/06/2023.
//

import Foundation

public enum AppError: Error {
    case errorMessage(message: String)
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorMessage(let message):
            return message
        }
    }
}
