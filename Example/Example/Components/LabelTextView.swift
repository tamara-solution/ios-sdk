//
//  LabelTextField.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct LabelTextView: View {
    var label: String
    var placeHolder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeHolder, text: $text)
                .padding(.all)
                .background(textFieldColor)
                .cornerRadius(5.0)
        }
    }
}
