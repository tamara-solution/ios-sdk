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
}   


class TamaraSDKCheckout: UIViewController {
    private var webView: WKWebView!
    private var url: String!
    public var delegate: TamaraCheckoutDelegate!
    
    private var successUrl: String!
    private var failedUrl: String!
    
    public init(url: String,merchantURL: TamaraMerchantURL) {
        self.url =  url
        self.successUrl = merchantURL.success
        self.failedUrl = merchantURL.failure
        super.init(nibName: nil, bundle: nil)
    }
    
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        successUrl = ""
        failedUrl = ""
        super.init(coder: aDecoder)
    }
    
    /// Creates the view that the controller manages.
    public override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

    /// Called after the controller's view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()

        guard let authUrl = url else { return }
        let myURL = URL(string: authUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = self
        webView.load(myRequest)
    }
    
    
    ///
    private func shouldDismiss(absoluteUrl: URL) {        
        if absoluteUrl.absoluteString.contains(self.successUrl) {
            // success url, dismissing the page with the payment token
            self.dismiss(animated: true) {
                self.delegate?.onSuccessfull()
            }
        } else {
            // fail url, dismissing the page
            self.dismiss(animated: true) {
                self.delegate?.onFailured()
            }
        }
    }
}

extension TamaraSDKCheckout: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        shouldDismiss(absoluteUrl: webView.url!)
    }

    /// Called when a web view receives a server redirect.
    public func webView(_ webView: WKWebView,
                        didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        // stop the redirection
        shouldDismiss(absoluteUrl: webView.url!)
    }
}
