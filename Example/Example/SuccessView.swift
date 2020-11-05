//
//  SuccessView.swift
//  Example
//
//  Created by Chuong Dang on 5/3/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct SuccessView : View {
//    var isSuccess: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            if appState.orderSuccessed {
            Text("Congratulation! Your order has been processed successfully.")
                .foregroundColor(.green)
            } else {
                Text("Sorry! Your order has been failured.")
                    .foregroundColor(.red)
            }
            
            RoundedButton(label: "Go Home", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
        }
        .navigationBarHidden(true)
        .navigationBarItems(trailing: HStack{})
        
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
