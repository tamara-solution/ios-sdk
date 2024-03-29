//
//  ContentView.swift
//  Example
//
//  Created by Chuong Dang on 4/22/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import TamaraSDK

struct ContentView : View {
    @EnvironmentObject var appState: AppState
    @State var cartPage: [String: String] = [:]
    @State var productPage: [String: String] = [:]
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        LoadingView(isLoading: self.$appState.isLoading) {
            NavigationView {
                if self.appState.currentPage == AppPages.Main {
                    MainView(cartPage: self.$cartPage, productPage: self.$productPage)
                } else if self.appState.currentPage == AppPages.Cart {
                    CartView()
                } else if self.appState.currentPage == AppPages.Custom {
                    CustomView()
                } else if self.appState.currentPage == AppPages.Info {
                    InfoView()
                } else if self.appState.currentPage == AppPages.Checkout {
                    CheckoutWebView()
                } else if self.appState.currentPage == AppPages.Success {
                    SuccessView()
                } else if self.appState.currentPage == AppPages.Test {
                    MyViewControllerRepresentation()
                } else if self.appState.currentPage == AppPages.CartPage {
                    if let urlString = self.cartPage["url"]{
                        WebViewContainer(urlString: urlString)
                    }
                } else if self.appState.currentPage == AppPages.Product {
                    if let urlString = self.productPage["url"]{
                        WebViewContainer(urlString: urlString)
                    }
                }
            }
        }.onAppear() {
            TamaraSDKPayment.shared.renderWidgetCartPage(language: WebViewParagrams.language.rawValue, country: WebViewParagrams.country.rawValue, publicKey: WebViewParagrams.publicKey.rawValue, amount: 250, completion: { [self] response, error, index in
                if let responseDic = response as? [String: String] {
                    self.cartPage = responseDic
                }
            })
            TamaraSDKPayment.shared.renderWidgetProduct(language: WebViewParagrams.language.rawValue, country: WebViewParagrams.country.rawValue, publicKey: WebViewParagrams.publicKey.rawValue, amount: 250, completion: { [self] response, error, index in
                if let responseDic = response as? [String: String] {
                    self.productPage = responseDic
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
