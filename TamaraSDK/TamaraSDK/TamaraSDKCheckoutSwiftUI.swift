//
//  WebView.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

@available(iOS 13.0.0, *)
public class TamaraSDKCheckoutSwiftUIViewModel: ObservableObject {
    
    @Published public var url: String
    @Published public var merchantURL: TamaraMerchantURL
    @Published public var webView: WKWebView
    @Published public var finishLoadingHandler: () -> Void = {}
    @Published public var successDirection: () -> Void = {}
    @Published public var failedDirection: () -> Void = {}
    
    public init(url: String? = "", merchantURL: TamaraMerchantURL = TamaraMerchantURL(success: "", failure: "", cancel: "", notification: ""),webView: WKWebView? = WKWebView()) {
        self.url = url ?? ""
        self.merchantURL = merchantURL
        self.webView = webView ?? WKWebView()
    }
}

@available(iOS 13.0.0, *)
public struct TamaraSDKCheckoutSwiftUI: View, UIViewRepresentable {
    @ObservedObject private var viewModel: TamaraSDKCheckoutSwiftUIViewModel
    
    public init(_ viewModel: TamaraSDKCheckoutSwiftUIViewModel) {
        self.viewModel = viewModel
    }
    
    public func makeUIView(context: UIViewRepresentableContext<TamaraSDKCheckoutSwiftUI>) -> WKWebView {
        self.viewModel.webView.navigationDelegate = context.coordinator
        self.viewModel.webView.uiDelegate = context.coordinator
        self.viewModel.webView.scrollView.bounces = false
        return self.viewModel.webView
    }
    
    public func updateUIView(_ uiView: TamaraSDKCheckoutSwiftUI.UIViewType, context: UIViewRepresentableContext<TamaraSDKCheckoutSwiftUI>) {
        return
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private var viewModel: TamaraSDKCheckoutSwiftUIViewModel
        
        init(_ viewModel: TamaraSDKCheckoutSwiftUIViewModel) {
            self.viewModel = viewModel
        }
        
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.finishLoadingHandler()
        }
        
        public func webView(_ webView: WKWebView,
                            didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            // stop the redirection
//            self.viewModel.finishLoadingHandler()
            if (webView.url!.absoluteString.contains(self.viewModel.merchantURL.success)) {
                self.viewModel.successDirection()
            } else if (webView.url!.absoluteString.contains(self.viewModel.merchantURL.failure)) {
                self.viewModel.failedDirection()
            } else {
                self.viewModel.finishLoadingHandler()
            }
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

    public func makeCoordinator() -> TamaraSDKCheckoutSwiftUI.Coordinator {
        Coordinator(viewModel)
    }
}
