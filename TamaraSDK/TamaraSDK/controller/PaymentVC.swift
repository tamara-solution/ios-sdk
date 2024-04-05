import UIKit
import Foundation

class PaymentVC: UIViewController {
    private let viewModel = ViewModel()
    static var shared = PaymentVC()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PaymentVC {
    func createOrder(order: Order?, completion: @escaping (Result<CheckoutSession, AppError>) -> ()) {
        viewModel.createOrder(order: order, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        })
    }
    
    func checkPaymentOptions(paymentOptions: PaymentOptions?, completion: @escaping (Result<PaymentOptionsResponse, AppError>) -> ()) {
        viewModel.checkPaymentOptions(paymentOptions: paymentOptions) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func authoriseOrder(orderId: String, completion: @escaping (Result<AuthoriseOrder, AppError>) -> ()) {
        viewModel.authoriseOrder(orderId: orderId) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func refunds(orderId: String, paymentRefund: PaymentRefund, completion: @escaping (Result<RefundsResponse, AppError>) -> ()) {
        viewModel.refunds(orderId: orderId, paymentRefund: paymentRefund) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func orderDetail(orderId: String, completion: @escaping (Result<OrderDetail, AppError>) -> ()) {
        viewModel.orderDetail(orderId: orderId, completion: { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
            }
        })
    }
    
    func capturePayment(capturePayment: CapturePaymentRequest, completion: @escaping (Result<CapturePayment, AppError>) -> ()) {
        viewModel.capturePayment(capturePayment: capturePayment, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                }
            }
        })
    }
    
    func cancelOrder(orderId: String, cancelOrder: CancelOrder, completion: @escaping (Result<CancelOrderResponse, AppError>) -> ()) {
        viewModel.cancelOrder(orderId: orderId, cancelOrder: cancelOrder, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                }
            }
        })
    }
    
    func updateOrderReference(orderId: String, orderReferenceId: String, completion: @escaping (Result<OrderReferenceResponse, AppError>) -> ()) {
        viewModel.updateOrderReference(orderId: orderId, orderReference: OrderReference(orderReferenceId: orderReferenceId), completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(AppError.errorMessage(message: error.localizedDescription)))
                }
            }
        })
    }
}



