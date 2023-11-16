//
//  HomeView.swift
//  WeatherApp
//
//  Created by Enrique Poyato Ortiz on 14/11/23.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385 // Height modal / screen`s height
}

struct HomeView: View {
    @State var bottonSheetposition: BottomSheetPosition = .middle
    @State var bottonSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottonSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    @State var hasDragged: Bool = false
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let screenGeight = proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom
                let imageOffset = screenGeight + 36
                ZStack {
                    // MARK: Background Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: Background Image
                    Image(.background)
                        .resizable()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        .ignoresSafeArea()
                    
                    // MARK: House Image
                    Image(.house)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)

                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)) {
                        Text("Montreal")
                            .font(.largeTitle)
                        
                        VStack {
                            Text(attributedString)
                                .multilineTextAlignment(.center)
                            
                            Text("H:24º   L:18º")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    
                    // MARK: Botton Sheet
                    BottomSheetView(position: $bottonSheetposition) {} content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                    }
                    .onBottomSheetDrag { translation in
                        bottonSheetTranslation = translation / screenGeight
                        withAnimation(.easeInOut) {
                            if bottonSheetposition == BottomSheetPosition.top {
                                hasDragged = true
                            } else {
                                hasDragged = false
                            }
                        }
                    }
                    
                    // MARK: Tab Bar
                    TabBar(action: {
                        bottonSheetposition = .top
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                    .ignoresSafeArea()
                    
                }
            }
            .toolbar(.hidden)
            
            
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19º" + (hasDragged ? " | " : "\n") + "Mostly Clear")
        
        if let temp = string.range(of: "19º") {
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .secondary : .primary
            
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
