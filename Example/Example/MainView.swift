//
//  ExampleView.swift
//  Example
//
//  Created by TruongThien on 5/8/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import SwiftUI
import TamaraSDK

struct MainView: View {
    @EnvironmentObject var appState: AppState
    var scriptCartPage: String = ""
    var scriptProduct: String = ""
    
    init(cartPage: Binding<[String: String]>, productPage: Binding<[String: String]>) {
        self.scriptCartPage = cartPage.wrappedValue["script"] ?? ""
        self.scriptProduct = productPage.wrappedValue["script"] ?? ""
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            Text("Tamara Checkout Example App")
            
            RoundedButton(label: "Init", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
            
            RoundedButton(label: "Test create order", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
            
            RoundedButton(label: "Test create order from url", buttonAction: {
                let merchantUrl = TamaraMerchantURL(
                    success: "tamara://checkout/success",
                    failure: "tamara://checkout/failure",
                    cancel: "tamara://checkout/cancel",
                    notification: "https://example.com/checkout/notification"
                )
                
                DispatchQueue.main.async {
                    self.appState.isLoading = false
                    let url = "https://checkout-sandbox.tamara.co/checkout/22464256-5aa0-4497-9121-165a10ea63be?locale=en_US&orderId=c66700d8-e723-48db-9f69-f0e73ff9b4e6&show_item_images=with_item_images_shown&pay_the_difference_disclaimer=blue2&pay_in_full_value=value_secure"
//                    self.appState.viewModel = TamaraSDKCheckoutSwiftUIViewModel(url: url, merchantURL: merchantUrl)
                    self.appState.currentPage = AppPages.Test
                }
//                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
            
            RoundedButton(label: "CartPage", buttonAction: {
                self.appState.currentPage = .CartPage
            })
                .padding(.top, 20)
            
            if !scriptCartPage.isEmpty {
                WebViewWrapper(html: scriptCartPage)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
            }
            
            RoundedButton(label: "Product", buttonAction: {
                self.appState.currentPage = .Product
            })
                .padding(.top, 20)
            
            if !scriptProduct.isEmpty {
                WebViewWrapper(html: scriptProduct)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
            }
        }
        .navigationBarHidden(true)
        .navigationBarItems(trailing: HStack{})
    }
    
    func calculateTotal() {
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
