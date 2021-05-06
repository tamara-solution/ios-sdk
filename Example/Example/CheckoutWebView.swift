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
    @ObservedObject var viewModel = TamaraSDKCheckoutViewModel()
    
    var body: some View {
        HStack {
            SDKViewController(url: appState.viewModel.url, merchantUrl: appState.viewModel.merchantURL)

        }
        .navigationBarTitle("Checkout", displayMode: .inline)

    }
    
}

@available(iOS 13.0.0, *)
struct CheckoutWebView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutWebView()
    }
}
