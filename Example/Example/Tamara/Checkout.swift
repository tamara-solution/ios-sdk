//
//  Checkout.swift
//  TamaraSDK
//
//  Created by Chuong Dang on 4/23/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import Foundation

public class TamaraCheckout {
    private var baseUrl: String
    private var merchantUsername: String?
    private var merchantPassword: String?
    private var token: String?
    private let encoder = JSONEncoder()
    
    public init(endpoint: String, merchantUsername: String, merchantPassword: String) {
        self.baseUrl = endpoint
        self.merchantUsername = merchantUsername
        self.merchantPassword = merchantPassword
    }
    
    public init(endpoint: String, token: String) {
        self.baseUrl = endpoint
        self.token = token
    }
    
    public func authenticate(successHandler: @escaping (_ token: String) -> Void, failHandler: @escaping (_ error: Error?) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        if token != nil {
            successHandler(token!)
            return
        }
        guard let username = self.merchantUsername, let password = self.merchantPassword else {return}
        let authenticateRequestBody = TamaraAuthenticateRequestBody(email: username, password: password)
        guard let url = URL(string: "\(baseUrl)/merchants/login") else {
            return
        }
        do {
            let data = try self.encoder.encode(authenticateRequestBody)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else { print(error!.localizedDescription); return }
                guard let data = data else {
                    failHandler(NSError(domain: "Empty authentication response", code: 500, userInfo: nil))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TamaraAuthenticateResponse.self, from: data)
                    UserDefaults.standard.set(response.token, forKey: "token")
                    successHandler(response.token)
                    return
                } catch {
                    failHandler(error)
                    return
                }
            }.resume()
        } catch {
            failHandler(error)
            return
        }
    }
    
    public func processCheckout(body: TamaraCheckoutRequestBody, checkoutComplete: @escaping (_ checkoutUrl: TamaraCheckoutSuccess?) -> Void, checkoutFailed: @escaping (_ error: TamaraCheckoutError?) -> Void) {
        if self.token != nil {
            self.doCheckout(token: self.token!, body: body, checkoutComplete: checkoutComplete, checkoutFailed: checkoutFailed)
        } else {
            self.authenticate(successHandler: { token in
                self.doCheckout(token: token, body: body, checkoutComplete: checkoutComplete, checkoutFailed: checkoutFailed)
            }, failHandler: {_ in })
        }
        
    }
    
    private func doCheckout(token: String, body: TamaraCheckoutRequestBody, checkoutComplete: @escaping (_ objectSucess: TamaraCheckoutSuccess) -> Void, checkoutFailed: @escaping (_ error: TamaraCheckoutError) -> Void) {
        //        do {
        if let data = try? self.encoder.encode(body) {
            print(String(decoding: data, as: UTF8.self))
            guard let url = URL(string: "\(baseUrl)/checkout") else {
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else { print(error!.localizedDescription); return }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    //handle case response error object
                    if httpResponse.statusCode == 200 {
                        try? checkoutComplete(TamaraCheckoutSuccess.decode(from: data ?? Data()))
                    } else {
                        try? checkoutFailed(TamaraCheckoutError.decode(from: data ?? Data()))
                    }
                }
                
            }.resume()
        }
    }
}


extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
