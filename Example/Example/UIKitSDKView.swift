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
    
    private let url: String
    private let merchantURL: TamaraMerchantURL
    private let delegate: TamaraCheckoutDelegate
    
    init(url:String, merchantUrl: TamaraMerchantURL, delegate: TamaraCheckoutDelegate) {
        self.url = url
        self.merchantURL = merchantUrl
        self.delegate = delegate
    }
    
    func makeUIViewController(context: Context) -> TamaraSDKCheckout {
        let vc = TamaraSDKCheckout(url: self.url, merchantURL: merchantURL)
        vc.delegate = delegate
        return vc
    }
    
    func updateUIViewController(_ uiViewController: TamaraSDKCheckout, context: Context) {
        uiViewController.delegate = delegate
    }
}

//MARK: - COORDINATOR
extension SDKViewController {
    
    public class Coordinator: NSObject {
    }
    
    public func makeCoordinator() -> SDKViewController.Coordinator {
        Coordinator()
    }

}

//MARK: - DELEGATE
extension SDKViewController {

    class Delegate: NSObject, TamaraCheckoutDelegate {

        private let sdkSuccess:() -> Void
        private let sdkFailed:() -> Void
        private let sdkCancel:() -> Void
        private let sdkNotification:() -> Void
        
        init(success didSuccess: @escaping(()->Void),
             failure didFailed: @escaping (()->Void),
             cancel didCancel: @escaping(()->Void),
            notification didNotification: @escaping (()->Void)){
            self.sdkSuccess = didSuccess
            self.sdkFailed = didFailed
            self.sdkCancel = didCancel
            self.sdkNotification = didNotification
        }
        
        public func onSuccessfull() {
            //Handle success
            self.sdkSuccess()
        }
        
        public func onFailured() {
            //Handle failured
            self.sdkFailed()
        }
        
        public func onCancel() {
            //Handle cancel
            self.sdkCancel()
        }
        
        public func onNotification() {
            //Handle notification
            self.sdkNotification()
        }
    }
}


