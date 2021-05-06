//
//  Constants.swift
//  Example
//
//  Created by Admin on 5/6/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import Foundation


var cartItems: [CartItem] = [
    CartItem(name: "Test Product 1", sku: "SKU-1", price: 100, tax: 0.5, quantity: 1),
    CartItem(name: "Test Product 2", sku: "SKU-2", price: 100, tax: 0.5, quantity: 1)
]

let ShippingAddress = CustomerAddress(
    firstName: "Mona",
    lastName: "Lisa",
    line1: "3764 Al Urubah Rd",
    line2: "Block A",
    region: "As Sulimaniyah",
    city: "Riyadh",
    countryCode: countryCode,
    phoneNumber: generatePhoneNumber()
)

let BillingAddress = CustomerAddress(
    firstName: "Mona",
    lastName: "Lisa",
    line1: "3764 Al Urubah Rd",
    line2: "Block A",
    region: "As Sulimaniyah",
    city: "Riyadh",
    countryCode: countryCode,
    phoneNumber: generatePhoneNumber()
)
