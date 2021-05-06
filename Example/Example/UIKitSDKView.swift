//
//  UIKitSDKView.swift
//  Example
//
//  Created by Admin on 5/6/21.
//  Copyright © 2021 Tamara. All rights reserved.
//

import Foundation
import SwiftUI

struct UIKitSDKView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitSDKViewController {
        let vc = UIKitSDKViewController()
        return vc
    }
    
    typealias UIViewControllerType = UIKitSDKViewController
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
