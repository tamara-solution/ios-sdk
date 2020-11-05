//
//  QuantityTextView.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct QuantityTextView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var quantity: Int
    var quantityChangedAction: () -> Void
    var body: some View {
        HStack {
            Button(action: {
                if (self.quantity) == 0 {
                    return
                }
                self.quantity = self.quantity - 1
                self.quantityChangedAction()
            }) {
                Image(systemName: "minus")
                    .font(.system(size: 20))
                    .padding(.all, 5)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
            }
            Spacer()
            TextField("0", value: self.$quantity, formatter: NumberFormatter())
                .background(colorScheme == .dark ? Color.gray : textFieldColor)
                .cornerRadius(5.0)
                .keyboardType(.numberPad)
            Spacer()
            Button(action: {
                self.quantity = self.quantity + 1
                self.quantityChangedAction()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .padding(.all, 5)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
            }
        }
    }
}
