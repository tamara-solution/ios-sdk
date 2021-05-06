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
    
    /// Called if the user get notification link
    func onNotification()
    
}   


public class TamaraSDKCheckout: UIViewController {
    private var webView: WKWebView!
    private var url: String!
    private var merchantURL: TamaraMerchantURL!
    public var delegate: TamaraCheckoutDelegate!
    
    public init(url: String,merchantURL: TamaraMerchantURL,webView: WKWebView? = WKWebView()) {
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

        guard let authUrl = url, authUrl.isEmpty == false else { return }
        let myURL = URL(string: authUrl)
        let myRequest = URLRequest(url: myURL!)
        
        if webView == nil {
            self.webView = WKWebView()
            self.webView.frame = self.view.bounds
        }
        self.webView.load(myRequest)
        self.webView.navigationDelegate = self
        view = webView
    }
    
}

extension TamaraSDKCheckout: WKNavigationDelegate, WKUIDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return
        }
        if url.absoluteString.contains("tamara://") {
            if (url.absoluteString.contains(self.merchantURL.success)) {
                self.delegate.onSuccessfull()
            } else if (url.absoluteString.contains(self.merchantURL.failure)) {
                self.delegate.onFailured()
            } else if (url.absoluteString.contains(self.merchantURL.cancel)) {
                self.delegate.onCancel()
            } else  {
                self.delegate.onNotification()
            }
        }
        decisionHandler(.allow)
    }
}
