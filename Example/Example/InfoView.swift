//
//  AddressView.swift
//  Example
//
//  Created by Chuong Dang on 4/25/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import TamaraSDK

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

struct InfoView : View {
    @EnvironmentObject var appState: AppState
    @State private var showLearnMore: Bool = false
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    var body: some View {
        List {
            LabelTextView(label: "First Name", placeHolder: "Mona", text: self.$appState.shippingAddress.firstName)
            LabelTextView(label: "Last Name", placeHolder: "Lisa", text: self.$appState.shippingAddress.lastName)
            LabelTextView(label: "Address Line 1", placeHolder: "3764 Al Urubah Rd", text: self.$appState.shippingAddress.line1)
            LabelTextView(label: "Address Line 2", placeHolder: "Block A", text: self.$appState.shippingAddress.line2)
            LabelTextView(label: "Region", placeHolder: "As Sulimaniyah", text: self.$appState.shippingAddress.region)
            LabelTextView(label: "City", placeHolder: "Riyadh", text: self.$appState.shippingAddress.city)
            LabelTextView(label: "Phone Number", placeHolder: "54116698", text: self.$appState.shippingAddress.phoneNumber)
            RoundedButton(label: "Checkout", buttonAction: self.checkout)
                .padding(.top, 20)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.horizontal, 5)
        .navigationBarTitle("Cart")
        .navigationBarItems(trailing:
            Button(action: {
                self.showLearnMore = true
            }) {
                Image(uiImage: UIImage(named: "help") ?? UIImage())
            }
        )
        .popover(isPresented: self.$showLearnMore, content: {
            TamaraPopupView()
        })
    }
    
    func checkout() {
        let tamaraCheckout = TamaraCheckout(endpoint: HOST, token: MERCHANT_TOKEN)
        
        self.appState.isLoading = true
        
        let totalAmountObject = TamaraAmount(amount: String(format:"%f", self.appState.orderTotal), currency: currency)
        
        let taxAmountObject = TamaraAmount(amount: String(format:"%f", self.appState.orderTaxTotal), currency: currency)
        
        let shippingAmountObject = TamaraAmount(amount: String(format:"%f", self.appState.orderShippingTotal), currency: currency)
        
        var itemList: [TamaraItem] = []
        self.appState.cartItems.forEach { (item) in
            itemList.append(TamaraItem(
                referenceID: UUID().uuidString,
                type: "Digital",
                name: item.name,
                sku: item.sku,
                quantity: 1,
                unitPrice: TamaraAmount(amount: String(format:"%f", item.price), currency: currency),
                discountAmount: TamaraAmount(amount: String(format:"%f", 0.0), currency: currency),
                taxAmount: TamaraAmount(amount: String(format:"%f", item.tax), currency: currency),
                totalAmount: TamaraAmount(amount: String(format:"%f", item.total), currency: currency)
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
            phoneNumber: generatePhoneNumber(),
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
        
        tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutSuccess) in
            // Handle success case
            DispatchQueue.main.async {
                self.appState.isLoading = false
                guard let item = checkoutSuccess else {return}
                self.appState.viewModel = TamaraSDKCheckoutViewModel(url: item.checkoutUrl, merchantURL: merchantUrl)
                self.appState.currentPage = AppPages.Checkout
            }

        }, checkoutFailed: { (checkoutFailed) in
            // Handle failed case
            print(checkoutFailed?.message ?? "")
            
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
