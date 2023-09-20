//
//  APIClient.swift
//
//

import Foundation

class APIClient: NSObject {
    static var shared = APIClient()
}

extension APIClient {
    func createOrder(order: Order?, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/checkout"
        let json = order?.convertToJson()
        Network.instance.requestWithUri(url, httpMethod: .post, httpBodyParameters: json as AnyObject) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func authoriseOrder(orderId: String?, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/orders/"+(orderId ?? "")+"/authorise"
        let json = ""
        Network.instance.requestWithUri(url, httpMethod: .post, httpBodyParameters: nil) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func refunds(orderId: String, paymentRefund: PaymentRefund, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/payments/simplified-refund/"+orderId
        let json = paymentRefund.convertToJson()
        Network.instance.requestWithUri(url, httpMethod: .post, httpBodyParameters: json as AnyObject) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func orderDetail(orderId: String, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/orders/"+orderId
        Network.instance.requestWithUri(url, httpMethod: .get, httpBodyParameters: nil) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func capturePayment(capturePayment: CapturePaymentRequest, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/payments/capture"
        let json = capturePayment.convertToJson()
        Network.instance.requestWithUri(url, httpMethod: .post, httpBodyParameters: json as AnyObject) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func cancelOrder(orderId: String, cancelOrder: CancelOrder, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/orders/"+orderId+"/cancel"
        let json = cancelOrder.convertToJson()
        Network.instance.requestWithUri(url, httpMethod: .post, httpBodyParameters: json as AnyObject) { code, response, error in
            completion(response, error, code)
        }
    }
    
    func updateOrderReference(orderId: String, orderReference: OrderReference, completion: @escaping (AnyObject?, Error?, Int) -> Void) -> Void {
        let url = TamaraSDKPayment.shared.apiUrl + "/orders/"+orderId+"/reference-id"
        let json = orderReference.convertToJson()
        Network.instance.requestWithUri(url, httpMethod: .put, httpBodyParameters: json as AnyObject) { code, response, error in
            completion(response, error, code)
        }
    }
}
