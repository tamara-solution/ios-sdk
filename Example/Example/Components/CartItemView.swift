//
//  CartItemView.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct CartItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var item: CartItem
    var quantityChangedAction: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                Text("SKU: \(item.sku)")
                    .foregroundColor(cartTextColor)
                Text("\(String(format: "%.2f", item.price)) \(currency)")
                    .foregroundColor(.green)
                Text("Tax: \(String(format: "%.2f", item.tax)) \(currency)")
                    .foregroundColor(cartTextColor)
            }
            Spacer()
            QuantityTextView(quantity: $item.quantity, quantityChangedAction: quantityChangedAction)
                .frame(width: 100, height: nil, alignment: .trailing)
        }
        .padding(.all, 5)
        .background(colorScheme == .dark ? Color.gray : Color.white)
    }
}
