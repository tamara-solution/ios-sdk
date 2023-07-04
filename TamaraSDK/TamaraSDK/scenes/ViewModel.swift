//
//  ViewModel.swift
//  tamara_sdk
//
//  Created by MAC on 20/06/2023.
//

import Foundation

class ViewModel {    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func createOrder(order: Order?, completion: @escaping (Result<CheckoutSession, AppError>) -> ()) {
        networkManager.createOrder(order: order) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func orderDetail(orderId: String, completion: @escaping (Result<OrderDetail, AppError>) -> ()) {
        networkManager.fetchOrderDetail(orderId: orderId) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func authoriseOrder(orderId: String, completion: @escaping (Result<AuthoriseOrder, AppError>) -> ()) {
        networkManager.authoriseOrder(orderId: orderId) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }

    func refunds(orderId: String, paymentRefund: PaymentRefund, completion: @escaping (Result<RefundsResponse, AppError>) -> ()) {
        networkManager.refunds(orderId: orderId, paymentRefund: paymentRefund) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func capturePayment(capturePayment: CapturePaymentRequest, completion: @escaping (Result<CapturePayment, AppError>) -> ()) {
        networkManager.capturePayment(capturePayment: capturePayment) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func cancelOrder(orderId: String, cancelOrder: CancelOrder, completion: @escaping (Result<CancelOrderResponse, AppError>) -> ()) {
        networkManager.cancelOrder(orderId: orderId, cancelOrder: cancelOrder) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func updateOrderReference(orderId: String, orderReference: OrderReference, completion: @escaping (Result<OrderReferenceResponse, AppError>) -> ()) {
        networkManager.updateOrderReference(orderId: orderId, orderReference: orderReference) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
}
