//
//  ExampleView.swift
//  Example
//
//  Created by TruongThien on 5/8/23.
//  Copyright © 2023 Tamara. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        VStack {
            Text("Tamara Checkout Example App")
            
            RoundedButton(label: "Init", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
            
            RoundedButton(label: "Test create order", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
            
            RoundedButton(label: "Get order detail", buttonAction: {
                self.appState.currentPage = .Cart
            })
                .padding(.top, 20)
        }
        .navigationBarHidden(true)
        .navigationBarItems(trailing: HStack{})
    }
    
    func calculateTotal() {
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
