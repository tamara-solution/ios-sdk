//
//  NetworkManager.swift
//  tamara_sdk
//
//  Created by MAC on 20/06/2023.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<TamaraApi> { get }
    func createOrder(order: Order?, completion: @escaping (Result<CheckoutSession, AppError>) -> ())
    func fetchOrderDetail(orderId: String, completion: @escaping (Result<OrderDetail, AppError>) -> ())
    func authoriseOrder(orderId: String, completion: @escaping (Result<AuthoriseOrder, AppError>) -> ())
    func refunds(orderId: String, paymentRefund: PaymentRefund, completion: @escaping (Result<RefundsResponse, AppError>) -> ())
    func capturePayment(capturePayment: CapturePaymentRequest, completion: @escaping (Result<CapturePayment, AppError>) -> ())
    func cancelOrder(orderId: String, cancelOrder: CancelOrder, completion: @escaping (Result<CancelOrderResponse, AppError>) -> ())
    func updateOrderReference(orderId: String, orderReference: OrderReference, completion: @escaping (Result<OrderReferenceResponse, AppError>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<TamaraApi>(plugins: [NetworkLoggerPlugin()])

    func createOrder(order: Order?, completion: @escaping (Result<CheckoutSession, AppError>) -> ()) {
        request(target: .createOrder(order: order), completion: completion)
    }
    
    func fetchOrderDetail(orderId: String, completion: @escaping (Result<OrderDetail, AppError>) -> ()) {
        request(target: .orderDetail(orderId: orderId), completion: completion)
    }
    
    func authoriseOrder(orderId: String, completion: @escaping (Result<AuthoriseOrder, AppError>) -> ()) {
        request(target: .authoriseOrder(orderId: orderId), completion: completion)
    }
    
    func refunds(orderId: String, paymentRefund: PaymentRefund, completion: @escaping (Result<RefundsResponse, AppError>) -> ()) {
        request(target: .refunds(orderId: orderId, paymentRefund: paymentRefund), completion: completion)
    }
    
    func capturePayment(capturePayment: CapturePaymentRequest, completion: @escaping (Result<CapturePayment, AppError>) -> ()) {
        request(target: .capturePayment(capturePayment: capturePayment), completion: completion)
    }
    
    func cancelOrder(orderId: String, cancelOrder: CancelOrder, completion: @escaping (Result<CancelOrderResponse, AppError>) -> ()) {
        request(target: .cancelOrder(orderId: orderId, cancelOrder: cancelOrder), completion: completion)
    }
    
    func updateOrderReference(orderId: String, orderReference: OrderReference, completion: @escaping (Result<OrderReferenceResponse, AppError>) -> ()) {
        request(target: .updateOrderReference(orderId: orderId, orderReference: orderReference), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: TamaraApi, completion: @escaping (Result<T, AppError>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                    case 200:
                        do {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(.success(results))
                        } catch let error {
                            completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                        }
                    default:
                        let str = String(decoding: response.data, as: UTF8.self)
                        completion(.failure(AppError.errorMessage(message: str)))
                    }
                
            case let .failure(error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
}


