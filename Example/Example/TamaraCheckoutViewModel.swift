//
//  TamaraCheckoutViewModel.swift
//  Example
//
//  Created by Admin on 5/6/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import Foundation
import TamaraSDK


public class TamaraSDKCheckoutViewModel: ObservableObject {
    
    @Published public var url: String
    @Published public var merchantURL: TamaraMerchantURL
    
    
    public init(url: String? = "", merchantURL: TamaraMerchantURL = TamaraMerchantURL(success: "", failure: "", cancel: "", notification: "")) {
        self.url = url ?? ""
        self.merchantURL = merchantURL
    }
}
