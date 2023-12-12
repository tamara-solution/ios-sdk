//
//  TamaraPayment.swift
//  TamaraSDK
//
//  Created by TruongThien on 5/4/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation
import UIKit

public class TamaraSDKPayment {
    public static var shared = TamaraSDKPayment()
    private let STATE_NEW = 0
    private let STATE_INITIALIZED = 1
    private let STATE_BEGIN = 2
    private let STATE_END = 3
    var token: String = ""
    var apiUrl: String = "http://api.tamara.co"
    private var pushUrl: String = ""
    private var publishKey: String = ""
    private var notificationToken: String = ""
    var isSandbox: Bool = true
    private var successUrl: String = ""
    private var failureUrl: String = ""
    private var cancelUrl: String = ""
    private var defaultCountryCode: String = "SA"
    private var order: Order?
    private var currency: String = "SAR"
    private var widgetSanboxUrl: String = "https://cdn-sandbox.tamara.co"
    private var widgetLiveUrl: String = "https://cdn.tamara.co"
    private var state: Int = 0
    
    public init() {}

    func resetOrder() {
        self.order = Order(countryCode: self.defaultCountryCode)
        self.state = self.STATE_BEGIN
    }
    
    private func buildOrder() throws -> Order? {
        var error = ""
        let size = order?.items?.count ?? 0
        if(order?.items == nil || size <= 0){
            error += "Order empty"
        }
        if(order?.shippingAddress == nil || order?.billingAddress == nil){
            error += "Shipping Address or Billing Address is required"
        }
        if(order?.consumer == nil){
            error += "Consumer is required"
        }
        if(order?.shippingAmount == nil){
            error += "Shipping Amount is required"
        }
        
        if (!error.isEmpty) {
            throw NSError(domain: "tamara", code: 1, userInfo: [NSLocalizedDescriptionKey: error])
        }
        
        var totalAmount = 0.0
        var totalTax = 0.0
        let shippingFee = order?.shippingAmount?.amount ?? 0.0
        let discount = order?.discount?.amount.amount ?? 0.0
        order?.items?.forEach { element in
            totalAmount += element.totalAmount?.amount ?? 0.0
            totalTax += element.taxAmount?.amount ?? 0.0
        }
        
        order?.merchantUrl = MerchantUrl(notification: pushUrl)
        order?.totalAmount = Amount(amount: totalAmount + shippingFee - discount, currency: currency)
        order?.taxAmount = Amount(amount: totalTax, currency: currency)
        return order
    }
    
    func validateDataRefunds(orderId: String?, paymentRefund : PaymentRefund?) throws-> Bool
    {
        var error = ""
        if(orderId == nil || orderId == ""){
            error += "Order id is required"
        }
        
        if (paymentRefund != nil) {
            if(paymentRefund?.totalAmount == nil){
                error += "Total amount id is required"
            }
            if(paymentRefund?.comment == nil || paymentRefund?.comment == ""){
                if (!error.isEmpty) {
                    error += "\n"
                }
                error += "Comment is required"
            }
        } else {
            if (!error.isEmpty) {
                error += "\n"
            }
            error += "Data refund is required"
        }
        
        if (!error.isEmpty) {
            throw NSError(domain: "tamara", code: 1, userInfo: [NSLocalizedDescriptionKey: error])
        }
        return true
    }
    
    func validateDataCancel(cancelOrder: CancelOrder?) throws-> Bool
    {
        var error = ""
        if (cancelOrder != nil) {
            if(cancelOrder?.totalAmount == nil){
                error += "totalAmount is required"
            }
        } else {
            error += "Data cancel is required"
        }
        
        if (!error.isEmpty) {
            throw NSError(domain: "tamara", code: 1, userInfo: [NSLocalizedDescriptionKey: error])
        }
        return true
    }
    
    func validateDataCapture(capturePayment : CapturePaymentRequest?) throws-> Bool
    {
        var error = ""
        if (capturePayment != nil) {
            if(capturePayment?.orderId == nil || capturePayment?.orderId == ""){
                error += "Order id is required"
            }
            
            if(capturePayment?.totalAmount == nil) {
                if (!error.isEmpty) {
                    error += "\n"
                }
                error += "Total Amount is required"
            }
            
            if(capturePayment?.shippingInfo == nil){
                if (error.isEmpty) {
                    error += "\n"
                }
                error += "Shipping Info is required"
            }
        } else {
            if (error.isEmpty) {
                error += "\n"
            }
            error += "Data capture is required"
        }
        
        if (!error.isEmpty) {
            throw NSError(domain: "tamara", code: 1, userInfo: [NSLocalizedDescriptionKey: error])
        }
        
        return true
    }
}

public extension TamaraSDKPayment {
    func validateStateForAddingData() throws {
        if(self.state < self.STATE_BEGIN){
            throw NSError(domain: "tamara", code: 1, userInfo: [NSLocalizedDescriptionKey: "Please call createOrder before add data to Tamara Payment."])
        }
    }
    
    func initialize(token: String, apiUrl: String, pushUrl: String, publishKey: String, notificationToken: String, isSandbox: Bool) {
        self.token = token
        self.apiUrl = apiUrl
        self.pushUrl = pushUrl
        self.publishKey = publishKey
        self.notificationToken = notificationToken
        self.isSandbox = isSandbox
        self.state = STATE_INITIALIZED
    }
    
    /**
     * Create order with reference id and description
     * @param orderReferenceId unique id on your server
     * @param description of this order
     */
    func createOrder(orderReferenceId: String, description: String) {
        if(self.state < self.STATE_INITIALIZED){
//            self.view.makeToast("Tamara Payment has not been initialed", position: .center)
        }
        self.resetOrder()
        self.order?.orderReferenceId = orderReferenceId
        self.order?.description = description
    }

    /**
    * Set Instalments
    * @param instalments
    */
    func setInstalments(instalments: Int) {
        do {
            try validateStateForAddingData()
            self.order?.instalments = instalments
        } catch {
        }
    }
    
    /**
     * Set Payment Type
     * @param paymentType
     */
    func setCountry(countryCode: String, currency: String) {
        self.defaultCountryCode = countryCode
    }
    
    /**
     * Set Payment Type
     * @param paymentType
     */
    func setPaymentType(paymentType: String) {
        do {
            try validateStateForAddingData()
            self.order?.paymentType = paymentType
        } catch {
        }
    }
    
    /**
     * Set Customer Information
     * @param firstName
     * @param lastName
     * @param phoneNumber
     * @param email
     * @param isFirstOrder true if this is first order of customer
     */
    func setCustomerInfo(firstName: String, lastName: String, phoneNumber: String, email: String, isFirstOrder: Bool = true) {
        do {
            try validateStateForAddingData()
            self.order?.consumer = Consumer(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, isFirstOrder: isFirstOrder)
        } catch {
        }
    }
    
    /**
     * Clear item
     */
    func clearItem() {
        do {
            try validateStateForAddingData()
            self.order?.items = Array()
        } catch {
        }
    }
    
    /**
     * Add an Item
     * @param name
     * @param referenceId reference id
     * @param sku
     * @param unitPrice original price of item
     * @param tax tax fee for each item
     * @param discount for each item
     * @param quantity
     */
    func addItem(name: String, referenceId: String, sku: String, type: String, unitPrice: Double,
                 tax: Double, discount: Double, quantity: Int) {
        do {
            try validateStateForAddingData()
            let currency = self.currency
            self.order?.items?.append(Item(name: name, referenceId: referenceId, sku: sku, type: type, unitPrice: Amount(amount: unitPrice, currency: currency), quantity: quantity, discountAmount: Amount(amount: discount, currency: currency), taxAmount: Amount(amount: tax, currency: currency), totalAmount: Amount(amount: (unitPrice + tax - discount) * Double(quantity), currency: currency)))
        } catch {
        }
    }
    
    /**
     * Set shipping address
     * @param firstName
     * @param lastName
     * @param phoneNumber
     * @param addressLine1 line 1 of address
     * @param addressLine2 line 2 of address
     * @param country The two-character ISO 3166-1 country code
     * @param region
     * @param city
     */
    func setShippingAddress(firstName: String, lastName: String, phoneNumber: String, addressLine1: String,
                            addressLine2: String, country: String, region: String, city: String) {
        do {
            try validateStateForAddingData()
            self.order?.shippingAddress = Address(firstName: firstName, lastName: lastName, line1: addressLine1, line2: addressLine2, region: region, city: city, countryCode: country, phoneNumber: phoneNumber)
        } catch {
        }
    }
    
    /**
     * Set billing address
     * @param firstName
     * @param lastName
     * @param phoneNumber
     * @param addressLine1 line 1 of address
     * @param addressLine2 line 2 of address
     * @param country The two-character ISO 3166-1 country code
     * @param region
     * @param city
     */
    func setBillingAddress(firstName: String, lastName: String, phoneNumber: String, addressLine1: String,
                           addressLine2: String, country: String, region: String, city: String){
        do {
            try validateStateForAddingData()
            self.order?.billingAddress = Address(firstName: firstName, lastName: lastName, line1: addressLine1, line2: addressLine2, region: region, city: city, countryCode: country, phoneNumber: phoneNumber)
        } catch {
        }
    }
    
    /**
     * Update currency if needed
     * @param newCurrency Default is SAR
     */
    func setCurrency(newCurrency: String){
        do {
            try validateStateForAddingData()
            self.currency = newCurrency
        } catch {
        }
    }
    
    /**
     * Set shipping fee
     * @param amount default currency is SAR
     */
    func setShippingAmount(amount: Double){
        do {
            try validateStateForAddingData()
            let currency = self.currency
            self.order?.shippingAmount = Amount(amount: amount, currency: currency)
        } catch {
        }
    }
    
    /**
     * Set discount for this order
     * @param amount discount value
     * @param name discount campaign's name
     */
    func setDiscount(amount: Double, name: String){
        do {
            try validateStateForAddingData()
            let currency = self.currency
            let discountAmount = Amount(amount: amount, currency: currency)
            let discount = Discount(amount: discountAmount, name: name)
            self.order?.discount = discount
        } catch {
        }        
    }
    
    /**
     * End session, request to create order again
     */
    func endSession() {
        self.state = self.STATE_END
    }
    
    /**
     * Start Tamara Payment Activity
     * @param activity Activity which will receive callback data form SDK
     */
    func startPayment(completion: @escaping (Result<CheckoutSession, AppError>) -> ()) {
        do {
            PaymentVC.shared.createOrder(order: try self.buildOrder(), completion: { result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                }
            })
        } catch {
            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
        }
    }
    
    func authoriseOrder(orderId: String, completion: @escaping (Result<AuthoriseOrder, AppError>) -> ())  {
        PaymentVC.shared.authoriseOrder(orderId: orderId) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func refunds(orderId: String, jsonData: String, completion: @escaping (Result<RefundsResponse, AppError>) -> ()) {
        do {
            let data = PaymentRefund(jsonData: Data(jsonData.utf8))
            let validateResult = try self.validateDataRefunds(orderId: orderId, paymentRefund: data)
            if (validateResult) {
                PaymentVC.shared.refunds(orderId: orderId, paymentRefund: data) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            completion(.success(response))
                        case .failure(let error):
                            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                        }
                    }
                    
                }
            }
        } catch {
            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
        }
    }
    
    func orderDetail(orderId: String, completion: @escaping (Result<OrderDetail, AppError>) -> ()) {
        PaymentVC.shared.orderDetail(orderId: orderId, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        })
    }
    
    func capturePayment(jsonData: String, completion: @escaping (Result<CapturePayment, AppError>) -> ()) {
        do {
            let data = try CapturePaymentRequest(jsonData: Data(jsonData.utf8))
            let validateResult = try self.validateDataCapture(capturePayment: data)
            if (validateResult) {
                PaymentVC.shared.capturePayment(capturePayment: data) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            completion(.success(response))
                        case .failure(let error):
                            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                        }
                    }
                    
                }
            }
        } catch {
            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
        }
    }
    
    func cancelOrder(orderId: String, jsonData: String, completion: @escaping (Result<CancelOrderResponse, AppError>) -> ()) {
        do {
            let data = try CancelOrder(jsonData: Data(jsonData.utf8))
            let validateResult = try self.validateDataCancel(cancelOrder: data)
            if (validateResult) {
                PaymentVC.shared.cancelOrder(orderId: orderId, cancelOrder: data) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            completion(.success(response))
                        case .failure(let error):
                            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                        }
                    }
                    
                }
            }
        } catch {
            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
        }
    }
    
    func updateOrderReference(orderId: String, orderReferenceId: String, completion: @escaping (Result<OrderReferenceResponse, AppError>) -> ()) {
        PaymentVC.shared.updateOrderReference(orderId: orderId, orderReferenceId: orderReferenceId) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    /**
     * cart page
     * @param language language value
     * @param country country id value
     * @param publicKey publicKey id value
     * @param amount amount id value
     */
    func renderWidgetCartPage(language: String, country: String, publicKey: String,
                              amount: Double, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        TamaraWidgetVC.shared.renderWidgetCartPage(language: language, country: country, publicKey: publicKey, amount: amount){ response, error, code in
            DispatchQueue.main.async {
                completion(response, error, code)
            }
        }
    }
    
    /**
     * product
     * @param language language value
     * @param country country id value
     * @param publicKey publicKey id value
     * @param amount amount id value
     */
    func renderWidgetProduct(language: String, country: String, publicKey: String,
                             amount: Double, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
       TamaraWidgetVC.shared.renderWidgetProduct(language: language, country: country, publicKey: publicKey, amount: amount){ response, error, code in
           DispatchQueue.main.async {
               completion(response, error, code)
           }
       }
   }
}
