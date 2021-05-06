//
//  UIKitSDKView.swift
//  Example
//
//  Created by Admin on 5/6/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import Foundation
import SwiftUI
import TamaraSDK

struct SDKViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = TamaraSDKCheckout
    
    private var url:String = ""
    private var merchantURL: TamaraMerchantURL = TamaraMerchantURL(success: "", failure: "", cancel: "", notification: "")
    
    public var onSuccess: (() -> Void)?
    public var onFailed: (() -> Void)?
    public var onCancel: (() -> Void)?
    public var onNotification: (() -> Void)?
    
    init(url:String, merchantUrl: TamaraMerchantURL) {
        self.url = url
        self.merchantURL = merchantUrl
    }
    
    func makeUIViewController(context: Context) -> TamaraSDKCheckout {
        let vc = TamaraSDKCheckout(url: self.url, merchantURL: merchantURL, webView: nil)
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: TamaraSDKCheckout, context: Context) {
    }
    
    
    public class Coordinator: NSObject, TamaraCheckoutDelegate {
        
        var parent:SDKViewController
        
        init(parent: SDKViewController){
            self.parent = parent
        }
        
        public func onSuccessfull() {
            //Handle success
            parent.onSuccess?()
        }
        
        public func onFailured() {
            //Handle failured
            parent.onFailed?()

        }
        
        public func onCancel() {
            //Handle cancel
            parent.onCancel?()

        }
        
        public func onNotification() {
            //Handle notification
            parent.onNotification?()

        }
    }
    
    public func makeCoordinator() -> SDKViewController.Coordinator {
        Coordinator(parent: self)
    }

}
