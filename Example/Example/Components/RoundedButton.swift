//
//  RoundedButton.swift
//  Example
//
//  Created by Chuong Dang on 4/24/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct RoundedButton : View {
    var label: String
    var buttonAction: () -> Void = {}
    var body: some View {
        Button(action: self.buttonAction) {
            HStack {
                Spacer()
                Text(self.label)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .background(Color.blue)
        .cornerRadius(4.0)
        .padding(.horizontal, 50)
    }
}
