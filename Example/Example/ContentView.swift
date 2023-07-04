//
//  ContentView.swift
//  Example
//
//  Created by Chuong Dang on 4/22/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var appState: AppState
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        LoadingView(isLoading: self.$appState.isLoading) {
            NavigationView {
                if self.appState.currentPage == AppPages.Main {
                    MainView()
                } else if self.appState.currentPage == AppPages.Cart {
                    CartView()
                } else if self.appState.currentPage == AppPages.Info {
                    InfoView()
                } else if self.appState.currentPage == AppPages.Checkout {
                    CheckoutWebView()
                } else if self.appState.currentPage == AppPages.Success {
                    SuccessView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
