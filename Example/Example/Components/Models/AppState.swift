//
//  NavigationViewModel.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation
import TamaraSDK

enum AppPages: Hashable {
    case Main
    case Cart
    case Info
    case Checkout
    case Success
    case Test
}

final class AppState: ObservableObject {
    @Published var currentPage : AppPages? = .Main
    @Published var url: String?
    @Published var isLoading: Bool = false
    @Published var orderSuccessed: Bool = false

    @Published var cartItems: [CartItem] = [
        CartItem(name: "Test Product 1", sku: "SKU-1", price: 100, tax: 0.5, quantity: 1),
        CartItem(name: "Test Product 2", sku: "SKU-2", price: 100, tax: 0.5, quantity: 1)
    ]
    @Published var orderTotal: Double = 0.0
    @Published var orderTaxTotal: Double = 0.0
    @Published var orderShippingTotal: Double = 0.0
    @Published var shippingAddress = CustomerAddress(
        firstName: "Mona",
        lastName: "Lisa",
        line1: "3764 Al Urubah Rd",
        line2: "Block A",
        region: "As Sulimaniyah",
        city: "Riyadh",
        countryCode: countryCode,
        phoneNumber: "502223333"
    )
    @Published var billingAddress = CustomerAddress(
        firstName: "Mona",
        lastName: "Lisa",
        line1: "3764 Al Urubah Rd",
        line2: "Block A",
        region: "As Sulimaniyah",
        city: "Riyadh",
        countryCode: countryCode,
        phoneNumber: "502223333"
    )
    
    @Published var viewModel: TamaraSDKCheckoutSwiftUIViewModel!
}
