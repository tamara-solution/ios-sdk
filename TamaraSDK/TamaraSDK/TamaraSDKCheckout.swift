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

public protocol TamaraCheckoutDelegate: AnyObject {
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
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        return webView
    }()
    
    private var navigationBarIsHidden: Bool = false
    private var isLoaded: Bool = false
    
    private var urlString: String = ""
    private var merchantURL: TamaraMerchantURL?
    
    public weak var delegate: TamaraCheckoutDelegate?
    
    public init(
        url: String,
        merchantURL: TamaraMerchantURL?
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.urlString = url
        self.merchantURL = merchantURL
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Called after the controller's view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraints()
        
        if !self.urlString.isEmpty, let url = URL(string: self.urlString) {
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nav = self.navigationController {
            self.navigationBarIsHidden = nav.navigationBar.isHidden
            nav.navigationBar.isHidden = true
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let nav = self.navigationController {
            nav.navigationBar.isHidden = self.navigationBarIsHidden
        }
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        self.setupViewInsets()
        
        self.view.addSubview(self.webView)
    }
    
    private func setupConstraints() {
        self.webView.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        self.webView.bottomAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
        ).isActive = true
        self.webView.leadingAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        self.webView.trailingAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
    }
    
    private func setupViewInsets() {
        var statusBarHeight: CGFloat = 0
        
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first {
                $0 is UIWindowScene && $0.activationState == .foregroundActive
            }
            if let windowScene = scene as? UIWindowScene, windowScene.statusBarManager?.isStatusBarHidden == false {
                statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
            }
        }
        else {
            if !UIApplication.shared.isStatusBarHidden {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
        }
        
        self.additionalSafeAreaInsets = .init(
            top: statusBarHeight,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    private func notifyDelegate(_ url: URL?) {
        guard
            let urlString = url?.absoluteString,
            !urlString.isEmpty,
            let merchantURL = self.merchantURL
        else { return }
        
        if (urlString.contains(merchantURL.success)) {
            self.delegate?.onSuccessfull()
        }
        else if (urlString.contains(merchantURL.failure)) {
            self.delegate?.onFailured()
        }
        else if (urlString.contains(merchantURL.cancel)) {
            self.delegate?.onCancel()
        }
        else if (urlString.contains(merchantURL.notification)) {
            self.delegate?.onNotification()
        }
    }
}

extension TamaraSDKCheckout: WKNavigationDelegate {
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        decisionHandler(.allow)
        self.notifyDelegate(navigationAction.request.url)
    }
    
    @available(iOS 13.0, *)
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        preferences: WKWebpagePreferences,
        decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void
    ) {
        decisionHandler(.allow, preferences)
        self.notifyDelegate(navigationAction.request.url)
    }
}
