//
//  LoadingView.swift
//  Example
//
//  Created by Chuong Dang on 4/25/20.
//  Copyright © 2020 Tamara. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding public var isLoading: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isLoading)
                    .blur(radius: self.isLoading ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.orange)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isLoading ? 1 : 0)
            }
        }
    }
}
