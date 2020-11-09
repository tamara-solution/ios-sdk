//
//  TamaraPopupView.swift
//  Example
//
//  Created by Admin on 10/28/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI
import TamaraSDK

struct TamaraPopupView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TamaraLearnMorePopup {
        let vc = TamaraLearnMorePopup()
        return vc
    }
    
    typealias UIViewControllerType = TamaraLearnMorePopup
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
