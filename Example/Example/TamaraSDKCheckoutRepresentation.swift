//
//  TamaraSDKCheckoutRepresentation.swift
//  Example
//
//  Created by MAC on 23/10/2023.
//  Copyright © 2023 Tamara. All rights reserved.
//
import Foundation
import WebKit
import UIKit
import SwiftUI
import TamaraSDK

@available(iOS 13.0, *)
public struct MyViewControllerRepresentation: UIViewControllerRepresentable, TamaraCheckoutDelegate{
    public func onSuccessfull() {
        print("onSuccessfull")
    }
    
    public func onFailured() {
        print("onFailured")
    }
    
    public func onCancel() {
        print("onCancel")
    }
    // 4
    public typealias UIViewControllerType = TamaraSDKCheckout
    
    public init() {}
    
    // 5
    public func makeUIViewController(context: Context) -> TamaraSDKCheckout {
        let merchantUrl = TamaraMerchantURL(
            success: "tamara://checkout/success",
            failure: "tamara://checkout/failure",
            cancel: "tamara://checkout/cancel",
            notification: "https://example.com/checkout/notification"
        )
    let url="https://checkout-sandbox.tamara.co/checkout/2a856ef5-69ef-47af-8326-2fa72037a5eb?locale=en_US&orderId=5a086d2c-baa2-45a1-893a-560584698645&show_item_images=with_item_images_shown&pay_the_difference_disclaimer=blue1&pay_in_full_value=value_secure"
        let d = TamaraSDKCheckout(url: url, merchantURL: merchantUrl)
        d.delegate = self
        return d
    }
    
    // 6
    public func updateUIViewController(_ uiViewController: TamaraSDKCheckout, context: Context) {
        
    }
}
