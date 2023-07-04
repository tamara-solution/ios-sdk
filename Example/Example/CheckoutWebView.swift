//
//  CheckoutWebView.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import WebKit
import TamaraSDK

@available(iOS 13.0, *)
struct CheckoutWebView: View {
    @EnvironmentObject var appState : AppState
    @ObservedObject var viewModel = TamaraSDKCheckoutSwiftUIViewModel()
    
    var body: some View {
        TamaraSDKCheckoutSwiftUI(viewModel)
            .onAppear {
                self.viewModel.successDirection = {
                    self.appState.isLoading = false
                    self.appState.orderSuccessed = true
                    self.appState.currentPage = .Success
                }
                
                self.viewModel.failedDirection = {
                    self.appState.isLoading = false
                    self.appState.orderSuccessed = false
                    self.appState.currentPage = .Success
                }
                
                var request = URLRequest(url: URL(string: appState.viewModel.url)!)
                request.setValue("Basic \(MERCHANT_TOKEN)", forHTTPHeaderField: "Authorization")
                self.viewModel.webView.load(request)
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .navigationBarItems(trailing: HStack {
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            }.disabled(!self.appState.viewModel.webView.canGoBack)
            Button(action: goForward) {
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
            }.disabled(!self.appState.viewModel.webView.canGoForward)
        })
    }
    
    func goBack() {
        self.viewModel.webView.goBack()
    }
    
    func goForward() {
        self.viewModel.webView.goForward()
    }
}

@available(iOS 13.0.0, *)
struct CheckoutWebView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutWebView()
    }
}
