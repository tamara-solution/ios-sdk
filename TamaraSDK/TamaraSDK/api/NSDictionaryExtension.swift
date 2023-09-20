//
//  NSDictionaryExtension.swift
//  TamaraSDK
//
//  Created by Thien on 24/05/2023.
//  Copyright © 2023 Tamara. All rights reserved.
//

import Foundation

extension NSDictionary {
    public func contentsAsURLQueryString() -> NSString? {
        let string: NSMutableString = ""
        let keys: [NSString] = self.allKeys as! [NSString]
        for key in keys {
            var value: AnyObject! = self.object(forKey: key) as AnyObject?
            if value.isKind(of: NSString.self) {
                // value is a string
            } else if value.responds(to: #selector(getter: NSNumber.stringValue)) {
                value = value.stringValue as AnyObject?
            } else {
                //bad parameters
                return nil
            }
            
            let parameterValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
            let toAppend = key == "" ? parameterValue : "\(key)=\(parameterValue ?? "")"
            string.append(toAppend!)
            
            if (keys.last != key) {
                string.append("&")
            }
        }
        return string;
    }
}
extension NSDictionary {
    var convertToJson: Data? {
        return try! JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
}
