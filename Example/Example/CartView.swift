//
//  CartView.swift
//  Example
//
//  Created by Chuong Dang on 4/26/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            ForEach(self.appState.cartItems.indices) { index in
                CartItemView(item: self.$appState.cartItems[index], quantityChangedAction: self.calculateTotal)
                    .id(index)
                    .cornerRadius(5.0)
                    .shadow(color: cartItemShadowColor, radius: 5, x: 5, y: 5)
            }
            Text("Total: \(String(format: "%.2f", self.appState.orderTotal)) \(currency)")
            RoundedButton(label: "Next", buttonAction: {
                self.appState.currentPage = AppPages.Info
            })
            .padding(.top, 20)  
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.horizontal, 5)
        .onAppear() {
            self.calculateTotal()
        }
        .navigationBarTitle("Cart")
    }
    
    func calculateTotal() {
        var subTotal = 0.0
        self.appState.cartItems.forEach { (item) in
            subTotal = subTotal + item.total
        }
        self.appState.orderTotal = subTotal
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

