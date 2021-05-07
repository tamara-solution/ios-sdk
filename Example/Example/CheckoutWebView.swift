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
            SDKViewController(url: appState.viewModel.url,
                              merchantUrl: appState.viewModel.merchantURL,
                              delegate: SDKViewController.Delegate (
                                success: {
                                    //Handle Success
                                    appState.orderSuccessed = true
                                    appState.currentPage = .Success
                                }, failure: {
                                    //Handle Failed
                                    appState.orderSuccessed = false
                                    appState.currentPage = .Success
                                }, cancel: {
                                    //Handle Cancel
                                    appState.currentPage = .Info
                                }, notification: {
                                    //Handle Notification
                                    appState.currentPage = .Info
                                })
            )
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
    }
}
