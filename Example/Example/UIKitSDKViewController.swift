//
//  UIKitSDKViewController.swift
//  Example
//
//  Created by Admin on 5/6/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import UIKit
import TamaraSDK

class UIKitSDKViewController: UIViewController {

    var tamaraSDK: TamaraSDKCheckout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    public init() {
        super.init(nibName: "UIKitSDKViewController", bundle: Bundle(for: UIKitSDKViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkout() {
        let tamaraCheckout = TamaraCheckout(endpoint: HOST, token: MERCHANT_TOKEN)
        
//        self.appState.isLoading = true
        
        let totalAmountObject = TamaraAmount(amount: String(format:"%.2f", 200.0), currency: currency)
        
        let taxAmountObject = TamaraAmount(amount: String(format:"%.2f", 0), currency: currency)
        
        let shippingAmountObject = TamaraAmount(amount: String(format:"%.2f", 0), currency: currency)
        
        var itemList: [TamaraItem] = []
        for item in cartItems {
            itemList.append(TamaraItem(
                referenceID: UUID().uuidString,
                type: "Digital",
                name: item.name,
                sku: item.sku,
                quantity: 1,
                unitPrice: TamaraAmount(amount: String(format:"%.2f", item.price), currency: currency),
                discountAmount: TamaraAmount(amount: String(format:"%.2f", 0.0), currency: currency),
                taxAmount: TamaraAmount(amount: String(format:"%.2f", item.tax), currency: currency),
                totalAmount: TamaraAmount(amount: String(format:"%.2f", item.total), currency: currency)
            ))
        }
        
        let shippingAddress = TamaraAddress(
            firstName: ShippingAddress.firstName,
            lastName: ShippingAddress.lastName,
            line1: ShippingAddress.line1,
            line2: ShippingAddress.line2,
            region: ShippingAddress.region,
            city: ShippingAddress.city,
            countryCode: ShippingAddress.countryCode,
            phoneNumber: ShippingAddress.phoneNumber
        )
        
        let billingAddress = TamaraAddress(
            firstName: BillingAddress.firstName,
            lastName: BillingAddress.lastName,
            line1: BillingAddress.line1,
            line2: BillingAddress.line2,
            region: BillingAddress.region,
            city: BillingAddress.city,
            countryCode: BillingAddress.countryCode,
            phoneNumber: BillingAddress.phoneNumber
        )
        
        let merchantUrl = TamaraMerchantURL(
            success: "tamara://checkout/success",
            failure: "tamara://checkout/failure",
            cancel: "tamara://checkout/cancel",
            notification: "https://example.com/checkout/notification"
        )
        
        let consumer = TamaraConsumer(
            firstName: "Mona",
            lastName: "Lisa",
            phoneNumber: generatePhoneNumber(),
            email: "user@example.com",
            nationalID: "123456",
            dateOfBirth: "2021-04-18",
            isFirstOrder: true
        )
        
        let requestBody = TamaraCheckoutRequestBody(
            orderReferenceID: UUID().uuidString,
            totalAmount: totalAmountObject,
            description: "description",
            countryCode: countryCode,
            paymentType: "PAY_BY_LATER",
            locale: "en-US",
            items: itemList,
            consumer: consumer,
            billingAddress: billingAddress,
            shippingAddress: shippingAddress,
            discount: nil,
            taxAmount: taxAmountObject,
            shippingAmount: shippingAmountObject,
            merchantURL: merchantUrl,
            platform: "iOS",
            isMobile: true,
            riskAssessment: nil
        )
        
        tamaraCheckout.processCheckout(body: requestBody, checkoutComplete: { (checkoutSuccess) in
            // Handle success case
            DispatchQueue.main.async {
                guard let item = checkoutSuccess else {return}
                self.tamaraSDK = TamaraSDKCheckout(url: item.checkoutUrl, merchantURL: merchantUrl)
                self.tamaraSDK.delegate = self
                self.present(self.tamaraSDK, animated: true, completion: nil)
            }
            
        }, checkoutFailed: { (checkoutFailed) in
            // Handle failed case
            print(checkoutFailed?.message ?? "")
            
            DispatchQueue.main.async {
                //Handel error
            }
        })
    }
    
}

extension UIKitSDKViewController {
    @IBAction func checkout(_ sender: Any) {
        self.checkout()
    }
}

extension UIKitSDKViewController: TamaraCheckoutDelegate {
    func onSuccessfull() {
        tamaraSDK.dismiss(animated: true) {
            //success handel
        }
    }
    
    func onFailured() {
        tamaraSDK.dismiss(animated: true) {
            //error handel
        }
    }
    
    func onCancel() {
        tamaraSDK.dismiss(animated: true) {
            //cancel handel
        }
    }
    
    func onNotification() {
        tamaraSDK.dismiss(animated: true) {
            //notification handel
        }
    }
    
}
