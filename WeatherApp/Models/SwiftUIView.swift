//
//  SwiftUIView.swift
//  WeatherApp
//
//  Created by Enrique Poyato Ortiz on 15/11/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        HomeIconShape()
            .frame(width: 258, height: 100)
    }
}

#Preview {
    SwiftUIView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background1)
}
