//
//  CustomView.swift
//  Example
//
//  Created by phong on 26/03/2024.
//  Copyright © 2024 Tamara. All rights reserved.
//

import SwiftUI

struct CustomView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        List {
            LabelTextView(label: "Risk Assessment", placeHolder: "{\"custom_field1\": 42, \"custom_field2\": \"value2\" }", text: self.$appState.riskAssessment)
            RoundedButton(label: "Next",  buttonAction: {
                self.appState.currentPage = AppPages.Info
            }).padding(.top, 20)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.horizontal, 5)
        .navigationBarTitle("Custom")
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}
