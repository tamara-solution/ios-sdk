//
//  WebView.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
//import Combine
import WebKit

@available(iOS 13.0.0, *)
public class TamaraSDKCheckoutViewModel: ObservableObject {
    
    @Published public var url: String
    @Published public var merchantURL: TamaraMerchantURL
    @Published public var webView: WKWebView
    @Published public var onCancel: () -> Void = {}
    @Published public var onSuccess: () -> Void = {}
    @Published public var onFailure: () -> Void = {}
    
    public init(url: String? = "", merchantURL: TamaraMerchantURL = TamaraMerchantURL(success: "", failure: "", cancel: "", notification: ""), webView: WKWebView? = WKWebView()) {
        self.url = url ?? ""
        self.merchantURL = merchantURL
        if webView == nil {
            self.webView = WKWebView()
            if let url = URL(string: self.url) {
                self.webView.load(URLRequest(url: url))
            }
        } else {
            self.webView = webView!
        }
    }
}

@available(iOS 13.0.0, *)
public struct TamaraSDKCheckoutView: View, UIViewRepresentable {
    @ObservedObject private var viewModel: TamaraSDKCheckoutViewModel
    
    public init(_ viewModel: TamaraSDKCheckoutViewModel) {
        self.viewModel = viewModel
    }
    
    public func makeUIView(context: UIViewRepresentableContext<TamaraSDKCheckoutView>) -> WKWebView {
        self.viewModel.webView.navigationDelegate = context.coordinator
        self.viewModel.webView.uiDelegate = context.coordinator
        self.viewModel.webView.scrollView.bounces = false
        return self.viewModel.webView
    }
    
    public func updateUIView(_ uiView: TamaraSDKCheckoutView.UIViewType, context: UIViewRepresentableContext<TamaraSDKCheckoutView>) {
        return
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private var viewModel: TamaraSDKCheckoutViewModel
        
        init(_ viewModel: TamaraSDKCheckoutViewModel) {
            self.viewModel = viewModel
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            guard let url = navigationAction.request.url else {
                return
            }
            if url.absoluteString.contains("tamara://") {
                let application = UIApplication.shared
                application.open(url, options: [ : ], completionHandler: nil)
            } else {
                //cancel or profile case
            }
            decisionHandler(.allow, preferences)
        }
    }

    public func makeCoordinator() -> TamaraSDKCheckoutView.Coordinator {
        Coordinator(viewModel)
    }
}
