//
//  TamaraApi.swift
//  tamara_sdk
//
//  Created by MAC on 20/06/2023.
//

import Foundation
import Moya

enum TamaraApi {
    case orderDetail(orderId:String)
    case createOrder(order: Order?)
    case checkPaymentOptions(paymentOptions: PaymentOptions?)
    case authoriseOrder(orderId:String)
    case refunds(orderId: String, paymentRefund: PaymentRefund)
    case capturePayment(capturePayment: CapturePaymentRequest)
    case cancelOrder(orderId: String, cancelOrder: CancelOrder)
    case updateOrderReference(orderId: String, orderReference: OrderReference)
}

extension TamaraApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: TamaraSDKPayment.shared.apiUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .orderDetail(let orderId):
            return "/orders/\(orderId)"
        case .createOrder:
            return "/checkout"
        case .checkPaymentOptions:
            return "/checkout/payment-options-pre-check"
        case .authoriseOrder(let orderId):
            return "/orders/\(orderId)/authorise"
        case .refunds(let orderId, _):
            return "/payments/simplified-refund/\(orderId)"
        case .capturePayment:
            return "/payments/capture"
        case .cancelOrder(let orderId, _):
            return "/orders/\(orderId)/cancel"
        case .updateOrderReference(let orderId, _):
            return "/orders/\(orderId)/reference-id"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .createOrder, .authoriseOrder, .refunds, .capturePayment, .cancelOrder,
                .checkPaymentOptions : return .post
            case .orderDetail: return .get
            case .updateOrderReference: return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .createOrder(let order):
            return .requestJSONEncodable(order)
        case .orderDetail(_), .authoriseOrder(_):
            return .requestPlain
        case .refunds(_, let paymentRefund):
            return .requestJSONEncodable(paymentRefund)
        case .capturePayment(let capturePayment):
            return .requestJSONEncodable(capturePayment)
        case .cancelOrder(_, let cancelOrder):
            return .requestJSONEncodable(cancelOrder)
        case .updateOrderReference(_, let orderReference):
            return .requestJSONEncodable(orderReference)
        case .checkPaymentOptions(let paymentOptions):
            return .requestJSONEncodable(paymentOptions)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "Authorization": "Bearer"+" "+TamaraSDKPayment.shared.token]
    }
}

