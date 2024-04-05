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
        .navigationBarBackButtonHidden(true)
    }
    
    func checkout() {
        let tamara = TamaraSDKPayment()
        self.appState.isLoading = true
        tamara.initialize(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhY2NvdW50SWQiOiJmY2ZiYzk3ZC0wYmIwLTRkYTItYmY3ZS02MjhlOTRkMzM0M2EiLCJ0eXBlIjoibWVyY2hhbnQiLCJzYWx0IjoiNzQxMmZkZjI1NGZiMWJhNmY5N2FmMmY1N2YxYzA1MDYiLCJpYXQiOjE2Nzc4MzIzNzQsImlzcyI6IlRhbWFyYSJ9.WVn2sf3LrW_YI3c2pNrbcOa--tRDAVm9p2GOBRdn7d671QIuqPvDgI9Gz7MNzBirUDnVLATCrL9uvMxDY_1OzXe3Sn1Gawckw-NE2EfL_Kjnl8GcNqwMcMvcin9XGxGRhbDDusgFCFzxaiEYae3DpA-pO0TpyQbEXl49ZLT4a9sEW75Taxc2ofZ-DJ_ciblImk1aJ6p9YhQowvzAVHz6yG-ZRfosxc96t8BK15bVTvTLnT9hzEnCqifqKO7vSu1e2mKEG8lC46pZHSr-ZpvfjSytrMX2QAZuXqxtlvbg3aRZeGiJ-SKVcbRdlId1wSRTZ5lntrw3pyrLS1dpxcfSOA", apiUrl: "https://api-sandbox.tamara.co", pushUrl: "https://tamara.co/pushnotification", publishKey: "d36c6279-90c2-4239-b4e2-2c91bfda0fe4", notificationToken: "aeae44a2-5f57-475e-a384-0e9b8a802326", isSandbox: true)
        tamara.createOrder(orderReferenceId: "A352BB0A59044C77928A7551A1EA566B", description: "String")
        tamara.setInstalments(instalments: 1)
        tamara.setLocale(locale: "en-US")
        let riskValidate = tamara.setRiskAssessment(jsonData: self.$appState.riskAssessment.wrappedValue)
        if (!riskValidate) {
            //check again json
        }
        tamara.setPaymentType(paymentType: "PAY_BY_INSTALMENTS")
        tamara.setCustomerInfo(firstName: "Mona", lastName: "Lisa", phoneNumber: "502223333", email: "user@gmail.com")
        
        tamara.clearItem()
        
        tamara.setAdditionalData(jsonData: "{\"custom_field1\": 42, \"custom_field2\": \"value2\" }")
        
        tamara.addCustomFieldsAdditionalData(jsonData: "{\"custom_field1\": 45, \"custom_field2\": \"value2\" }")
        
        tamara.addItem(name: "Lego City 8601", referenceId:  "123456_item", sku: "SA-12436", type: "Digital", unitPrice: 50.0, tax: 10.0, discount: 25.0, quantity: 1)
        
        tamara.addItem(name: "Batman", referenceId:  "123457_item", sku: "SA-12437", type: "Digital", unitPrice: 25.0, tax: 10.0, discount: 5.0, quantity: 1)
        
        tamara.addItem(name: "Spider man", referenceId:  "123458_item", sku: "SA-12438", type: "Digital", unitPrice: 25.0, tax: 10.0, discount: 5.0, quantity: 1)
        
        tamara.addItem(name: "Thor", referenceId:  "123459_item", sku: "SA-12439", type: "Digital", unitPrice: 100.0, tax: 10.0, discount: 25.0, quantity: 1)
        
        tamara.addItem(name: "Iron man", referenceId:  "123460_item", sku: "SA-12460", type: "Digital", unitPrice: 500.0, tax: 10.0, discount: 0.0, quantity: 1)
        
        tamara.setShippingAmount(amount: 20.0)
        
        tamara.setDiscount(amount: 100.0, name: "Launch event's discount")

        tamara.setShippingAddress(firstName: "Mona", lastName: "Lisa", phoneNumber: "502223337", addressLine1: "3764 Al Urubah Rd", addressLine2: "", country: "SA", region: "As Sulimaniyah", city: "Riyadh")
        
        tamara.setBillingAddress(firstName: "Mona", lastName: "Lisa", phoneNumber: "502223337", addressLine1: "3764 Al Urubah Rd", addressLine2: "", country: "SA", region: "As Sulimaniyah", city: "Riyadh")
        
        tamara.startPayment() { result in
            do {
                            self.appState.isLoading = false
                            switch result {
                            case .success(let response):
                                let jsonEncoder = JSONEncoder()
                                let decoder = JSONDecoder()
                                let checkout = try decoder.decode(TamaraCheckoutResponse.self, from: jsonEncoder.encode(response))
                                let strUrl = checkout.checkoutUrl
                                let merchantUrl = TamaraMerchantURL(
                                    success: "tamara://checkout/success",
                                    failure: "tamara://checkout/failure",
                                    cancel: "tamara://checkout/cancel",
                                    notification: "https://example.com/checkout/notification"
                                )
                                if strUrl != "" {
                                    self.appState.viewModel = TamaraSDKCheckoutSwiftUIViewModel(url: strUrl, merchantURL: merchantUrl)
                                    self.appState.currentPage = AppPages.Checkout
                                }
                            case .failure(let error):
                                print(error)
                                break
                            }
                        } catch {
                            print(error)
                        }
        }
//        let tamaraCheckout = TamaraCheckout(endpoint: HOST, token: MERCHANT_TOKEN)
                
//        let totalAmountObject = TamaraAmount(amount: self.appState.orderTotal, currency: currency)
//
//        let taxAmountObject = TamaraAmount(amount: self.appState.orderTaxTotal, currency: currency)
//
//        let shippingAmountObject = TamaraAmount(amount: self.appState.orderShippingTotal, currency: currency)
//
//        var itemList: [TamaraItem] = []
//        self.appState.cartItems.forEach { (item) in
//
//            itemList.append(TamaraItem(
//                referenceID: UUID().uuidString,
//                type: "Digital",
//                name: item.name,
//                sku: item.sku,
//                quantity: 1,
//                unitPrice: TamaraAmount(amount: item.price, currency: currency),
//                discountAmount: TamaraAmount(amount: 0.0, currency: currency),
//                taxAmount: TamaraAmount(amount: item.tax, currency: currency),
//                totalAmount: TamaraAmount(amount: item.total, currency: currency)
//            ))
//        }
        
//        let shippingAddress = TamaraAddress(
//            firstName: self.appState.shippingAddress.firstName,
//            lastName: self.appState.shippingAddress.lastName,
//            line1: self.appState.shippingAddress.line1,
//            line2: self.appState.shippingAddress.line2,
//            region: self.appState.shippingAddress.region,
//            city: self.appState.shippingAddress.city,
//            countryCode: self.appState.shippingAddress.countryCode,
//            phoneNumber: self.appState.shippingAddress.phoneNumber
//        )
//
//        let billingAddress = TamaraAddress(
//            firstName: self.appState.billingAddress.firstName,
//            lastName: self.appState.billingAddress.lastName,
//            line1: self.appState.billingAddress.line1,
//            line2: self.appState.billingAddress.line2,
//            region: self.appState.billingAddress.region,
//            city: self.appState.billingAddress.city,
//            countryCode: self.appState.billingAddress.countryCode,
//            phoneNumber: self.appState.billingAddress.phoneNumber
//        )
//
//        let merchantUrl = TamaraMerchantURL(
//            success: "tamara://checkout/success",
//            failure: "tamara://checkout/failure",
//            cancel: "tamara://checkout/cancel",
//            notification: "https://example.com/checkout/notification"
//        )
//
//        let consumer = TamaraConsumer(
//            firstName: "Mona",
//            lastName: "Lisa",
//            phoneNumber: "502223333",
//            email: "user@example.com",
//            nationalID: "123456",
//            dateOfBirth: "2020-04-18",
//            isFirstOrder: true
//        )
        
        
//        let requestBody = TamaraCheckoutRequestBody(
//            orderReferenceID: UUID().uuidString,
//            totalAmount: totalAmountObject,
//            description: "description",
//            countryCode: countryCode,
//            paymentType: "PAY_BY_LATER",
//            locale: "en-US",
//            items: itemList,
//            consumer: consumer,
//            billingAddress: billingAddress,
//            shippingAddress: shippingAddress,
//            discount: nil,
//            taxAmount: taxAmountObject,
//            shippingAmount: shippingAmountObject,
//            merchantURL: merchantUrl,
//            platform: "iOS",
//            isMobile: true,
//            riskAssessment: nil
//        )
//
//        tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutUrl) in
//
//            ///call TAMARA SDK show webview
//            DispatchQueue.main.async {
//                self.appState.isLoading = false
//                guard let url = checkoutUrl else {return}
//                self.appState.viewModel = TamaraSDKCheckoutSwiftUIViewModel(url: url, merchantURL: merchantUrl)
//                self.appState.currentPage = AppPages.Checkout
//            }
//
//        }, checkoutFailed: { (error) in
//            print(error)
//            DispatchQueue.main.async {
//                self.appState.isLoading = false
//                self.appState.orderSuccessed = false
//                self.appState.currentPage = AppPages.Success
//            }
//        })
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
