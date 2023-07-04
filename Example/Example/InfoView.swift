//
//  AddressView.swift
//  Example
//
//  Created by Chuong Dang on 4/25/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import TamaraSDK

struct InfoView : View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            LabelTextView(label: "First Name", placeHolder: "Mona", text: self.$appState.shippingAddress.firstName)
            LabelTextView(label: "Last Name", placeHolder: "Lisa", text: self.$appState.shippingAddress.lastName)
            LabelTextView(label: "Address Line 1", placeHolder: "3764 Al Urubah Rd", text: self.$appState.shippingAddress.line1)
            LabelTextView(label: "Address Line 2", placeHolder: "Block A", text: self.$appState.shippingAddress.line2)
            LabelTextView(label: "Region", placeHolder: "As Sulimaniyah", text: self.$appState.shippingAddress.region)
            LabelTextView(label: "City", placeHolder: "Riyadh", text: self.$appState.shippingAddress.city)
            LabelTextView(label: "Phone Number", placeHolder: "502223333", text: self.$appState.shippingAddress.phoneNumber)
            RoundedButton(label: "Checkout", buttonAction: self.checkout)
                .padding(.top, 20)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.horizontal, 5)
        .navigationBarTitle("Customer Info")

    }
    
    func checkout() {
        let tamaraCheckout = TamaraCheckout(endpoint: HOST, token: MERCHANT_TOKEN)
        
        self.appState.isLoading = true
        
        let totalAmountObject = TamaraAmount(amount: self.appState.orderTotal, currency: currency)
        
        let taxAmountObject = TamaraAmount(amount: self.appState.orderTaxTotal, currency: currency)
        
        let shippingAmountObject = TamaraAmount(amount: self.appState.orderShippingTotal, currency: currency)
        
        var itemList: [TamaraItem] = []
        self.appState.cartItems.forEach { (item) in
            itemList.append(TamaraItem(
                referenceID: UUID().uuidString,
                type: "Digital",
                name: item.name,
                sku: item.sku,
                quantity: 1,
                unitPrice: TamaraAmount(amount: item.price, currency: currency),
                discountAmount: TamaraAmount(amount: 0.0, currency: currency),
                taxAmount: TamaraAmount(amount: item.tax, currency: currency),
                totalAmount: TamaraAmount(amount: item.total, currency: currency)
            ))
        }
        
        let shippingAddress = TamaraAddress(
            firstName: self.appState.shippingAddress.firstName,
            lastName: self.appState.shippingAddress.lastName,
            line1: self.appState.shippingAddress.line1,
            line2: self.appState.shippingAddress.line2,
            region: self.appState.shippingAddress.region,
            city: self.appState.shippingAddress.city,
            countryCode: self.appState.shippingAddress.countryCode,
            phoneNumber: self.appState.shippingAddress.phoneNumber
        )
        
        let billingAddress = TamaraAddress(
            firstName: self.appState.billingAddress.firstName,
            lastName: self.appState.billingAddress.lastName,
            line1: self.appState.billingAddress.line1,
            line2: self.appState.billingAddress.line2,
            region: self.appState.billingAddress.region,
            city: self.appState.billingAddress.city,
            countryCode: self.appState.billingAddress.countryCode,
            phoneNumber: self.appState.billingAddress.phoneNumber
        )
        
        let merchantUrl = TamaraMerchantURL(
            success: "tamara://checkout/success",
            failure: "tamara://checkout/failure",
            cancel: "tamara://checkout/cancel",
            notification: "https://example.com/checkout/notification"
        )
        
        let consumer = TamaraConsumer(
            firstName: "Mona",
            lastName: "Lisa",
            phoneNumber: "502223333",
            email: "user@example.com",
            nationalID: "123456",
            dateOfBirth: "2020-04-18",
            isFirstOrder: true
        )
        
        let requestBody = TamaraCheckoutRequestBody(
            orderReferenceID: UUID().uuidString,
            totalAmount: totalAmountObject,
            description: "description",
            countryCode: countryCode,
            paymentType: "PAY_BY_LATER",
            locale: "en-US",
            items: itemList,
            consumer: consumer,
            billingAddress: billingAddress,
            shippingAddress: shippingAddress,
            discount: nil,
            taxAmount: taxAmountObject,
            shippingAmount: shippingAmountObject,
            merchantURL: merchantUrl,
            platform: "iOS",
            isMobile: true,
            riskAssessment: nil
        )
        
        tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutUrl) in
                
            ///call TAMARA SDK show webview
            DispatchQueue.main.async {
                self.appState.isLoading = false
                guard let url = checkoutUrl else {return}
                self.appState.viewModel = TamaraSDKCheckoutSwiftUIViewModel(url: url, merchantURL: merchantUrl)
                self.appState.currentPage = AppPages.Checkout
            }

        }, checkoutFailed: { (error) in
            print(error)
            DispatchQueue.main.async {
                self.appState.isLoading = false
                self.appState.orderSuccessed = false
                self.appState.currentPage = AppPages.Success
            }
        })
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
