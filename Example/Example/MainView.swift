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
    
    init() {
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
                    let url = "https://checkout-sandbox.tamara.co/checkout/25a5229c-99a6-47af-b9e3-d475e8557fd0?locale=en_US&orderId=078d049c-1614-4182-b9d1-8b021c9b1b93&show_item_images=with_item_images_shown&pay_the_difference_disclaimer=blue2&id_match_another_user=changing_phone&pay_in_full_value=full_values"
                    self.appState.viewModel = TamaraSDKCheckoutSwiftUIViewModel(url: url, merchantURL: merchantUrl)
                    self.appState.currentPage = AppPages.Checkout
                }
//                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
        }
        .navigationBarHidden(true)
        .navigationBarItems(trailing: HStack{})
    }
    
    func calculateTotal() {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
