//
//  WebviewCheckout.swift
//  TamaraSDK
//
//  Created by Admin on 10/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation
import WebKit
import UIKit
import SwiftUI

public protocol TamaraCheckoutDelegate: class {

    /// Called if the response is successful
    func onSuccessfull()

    /// Called if the response is unsuccesful
    func onFailured()
    
    /// Called if the user cancel
    func onCancel()
    
    /// Called if the user cancel
    func onNotification()
    
    /// Called when user cancel
    func quit()
}   


public class TamaraSDKCheckout: UIViewController {
    private var webView: WKWebView!
    private var url: String!
    private var merchantURL: TamaraMerchantURL!
    public var delegate: TamaraCheckoutDelegate!
    

    
    public init(childController: UIViewController,url: String,merchantURL: TamaraMerchantURL,webView: WKWebView? = WKWebView()) {
        self.url =  url
        self.merchantURL = merchantURL
        if let webV = webView {
            self.webView = webV
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Called after the controller's view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()

        guard let authUrl = url else { return }
        let myURL = URL(string: authUrl)
        let myRequest = URLRequest(url: myURL!)
        
//        let webConfiguration = WKWebViewConfiguration()
        
        if webView == nil {
            self.webView = WKWebView()
            self.webView.frame = self.view.bounds
        }
        self.webView.load(myRequest)
        self.webView.navigationDelegate = self
        view = webView
    }
    
    ///
    private func redirect(absoluteUrl: URL) {        
        if absoluteUrl.absoluteString.contains(self.merchantURL.success) {
            // success url, dismissing the page with the payment token
            self.delegate?.onSuccessfull()
        } else if absoluteUrl.absoluteString.contains(self.merchantURL.failure) {
            // fail url, dismissing the page
            self.delegate?.onFailured()
        } else if absoluteUrl.absoluteString.contains(self.merchantURL.cancel) {
            self.delegate.onCancel()
        }  else if absoluteUrl.absoluteString.contains(self.merchantURL.notification) {
            self.delegate.onNotification()
        } else {
            self.delegate.quit()
        }
    }
}

extension TamaraSDKCheckout: WKNavigationDelegate, WKUIDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.viewModel.finishLoadingHandler()
    }
    
    public func webViewDidClose(_ webView: WKWebView) {
        self.delegate.quit()
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        if (webView.url!.absoluteString.contains(self.merchantURL.success)) {
            self.delegate.onSuccessfull()
        } else if (webView.url!.absoluteString.contains(self.merchantURL.failure)) {
            self.delegate.onFailured()
        } else {
            if !webView.url!.absoluteString.contains("tamara.co") {
                self.delegate.quit()
            }
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return
        }
        if url.absoluteString.contains("tamara://") {
            if url.absoluteString.contains("cancel") {
                self.delegate.quit()
            }  
        }
        decisionHandler(.allow)
    
    }
}
