//
//  Network.swift
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE", patch = "PATCH"
}

class Network: NSObject, URLSessionDataDelegate {
    static var instance = Network()
    let urlSession: URLSession = Foundation.URLSession.shared
    let hostURL = ""
}
//MARK: Public API
extension Network {

    //with uniform resource identifier
    public func requestWithUri(_ uri:String,
        httpMethod: HTTPMethod,
        httpBodyParameters:AnyObject?,
        completion: ((Int, AnyObject?, NSError?) -> Void)!){
            _request(uri, httpMethod: httpMethod, httpBody: httpBodyParameters, shouldAppendURL: true, completion: completion)
    }
    
    public func requestWithUri(_ uri:String,
        httpMethod: HTTPMethod,
        httpBodyParameters:AnyObject?,
        isJSONObject:Bool,
        completion: ((Int, AnyObject?, NSError?) -> Void)!){
            _request(uri, httpMethod: httpMethod, httpBody: httpBodyParameters, shouldAppendURL: true, isJSONObject : isJSONObject,completion: completion)
    }
    
    //with uniform resource locator
    public func requestWithUrl(_ url:String,
        httpMethod: HTTPMethod,
        httpBodyParameters:AnyObject?,
        completion: @escaping ((Int, AnyObject?, NSError?) -> Void)){
            _request(url, httpMethod: httpMethod, httpBody: httpBodyParameters, shouldAppendURL: false, completion: completion)
    }
    
}

//MARK: Private Methods
extension Network {
    fileprivate func _request(_ target:String,
        httpMethod:HTTPMethod,
        httpBody: AnyObject?,
        shouldAppendURL : Bool,
        isJSONObject : Bool,
        completion: ((Int, AnyObject?, NSError?) -> Void)!)
    {
        let url : String = "\(self.hostURL)\(target)"
        print("Outgoing URL : \(url)")
        
        if let encodedURLString = (url as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue){
            let request = buildHttpRequest(encodedURLString, httpBody: httpBody, isJSONObject : isJSONObject, httpMethod: httpMethod)
            print("[REQUEST]: Headers \(request.allHTTPHeaderFields)")
            urlSession.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                var sCode = Int()
                if (error == nil) {
                    // Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    sCode = statusCode
                    print("URL Session Task Succeeded: HTTP \(statusCode)")
                }
                else {
                    // Failure
                    print("URL Session Task Failed: %@", error!.localizedDescription);
                }
                
                var status : String = ""
                var content : AnyObject? = nil
                if error != nil {
                    print("HTTP request error code:\(status) : \(error!.localizedDescription), for URL: \(url)")
                    status = "-999" //network error
                    completion(sCode, nil, error as NSError?)
                } else {
                    let responseData: NSString? = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    (status, content) = JSONSerialization.parseBasicResponse(data!)
                    if let contentExists: AnyObject = content{
                        print("[RESPONSE]: \(responseData)")
                        completion(sCode, contentExists, nil)
                    }
                }
            }).resume()
        }
    }
    
    fileprivate func _request(_ target:String,
        httpMethod:HTTPMethod,
        httpBody: AnyObject?,
        shouldAppendURL : Bool,
        completion: ((Int , AnyObject?, NSError?) -> Void)!)
    {
        _request(target, httpMethod: httpMethod, httpBody: httpBody, shouldAppendURL: shouldAppendURL, isJSONObject : false, completion: completion)
    }
    
    public func buildHttpRequest(_ urlString: String,
        httpBody: AnyObject?,
        isJSONObject : Bool,
        httpMethod: HTTPMethod) -> NSMutableURLRequest {
            
            if let url = URL(string: urlString){
                
                let request = NSMutableURLRequest(url:url)
                request.httpMethod = httpMethod.rawValue
                
                
                // Headers
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("Bearer"+" "+TamaraSDKPayment.shared.token, forHTTPHeaderField: "Authorization")
                print("Bearer"+" "+TamaraSDKPayment.shared.token)
                //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                if let bodyParams = httpBody as? NSDictionary {
                    //var error: NSError?
                    
                    if let body: NSString = bodyParams.contentsAsURLQueryString(){
                        if isJSONObject {
                            do {
                                let value = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                                request.httpBody = value
                            }
                                
                            catch let error as NSError {
                                print("HTTPBODY : A JSON Object build error occurred, here are the details:\n \(error)")
                            }

                        } else {
                            request.httpBody = body.data(using: String.Encoding.utf8.rawValue)
                        }
                    }
                    else{
                        
                        do {
                            let value = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                            request.httpBody = value
                        }
                            
                        catch let error as NSError {
                            print("HTTPBODY : A JSON Object build error occurred, here are the details:\n \(error)")
                        }
                    }
                    
        
                    
                } else if let bodyParams = httpBody as? NSArray {
                    
                    do {
                        let value = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                        request.httpBody = value
                    }
                        
                    catch let error as NSError {
                        print("HTTPBODY : A JSON Object build error occurred, here are the details:\n \(error)")
                    }
                }
                else if let bodyParams = httpBody as? NSString{
                    //var error: NSError?
                    if let body = bodyParams.data(using: String.Encoding.utf8.rawValue) {
                        request.httpBody = body
                    }
                }
                else if let bodyParams = httpBody as? Data {
                    request.httpBody = bodyParams
                }
                else if let bodyParams = httpBody as? Bool {
                    let booleanString = bodyParams ? "true" : "false"
                    request.httpBody = booleanString.data(using: String.Encoding.utf8)
                }
                
                return request
            }
            return NSMutableURLRequest()
    }
    
    fileprivate func _buildHttpRequest(_ urlString: String,
        httpBody: AnyObject?,
        httpMethod: HTTPMethod) -> NSMutableURLRequest {
            return buildHttpRequest(urlString, httpBody: httpBody, isJSONObject : false, httpMethod: httpMethod)
    }
}
