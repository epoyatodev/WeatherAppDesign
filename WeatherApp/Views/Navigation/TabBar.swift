//
//  TabBar.swift
//  WeatherApp
//
//  Created by Enrique Poyato Ortiz on 14/11/23.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            
            
            // MARK: Arc shape
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay {
                    Arc()
                        .stroke(Color.tabBarBorder, lineWidth: 0.5)
                    HomeIconShape()
                        .frame(width: 258, height: 100)
                        .foregroundStyle(.tabBarBackground2)
                        .overlay(alignment: .top) {
                            Circle()
                                .frame(width: 64)
                                .padding(.top, 12)
                                .overlay() {
                                    Image(.plus)
                                        .resizable()
                                        .padding(2)
                                        .frame(width: 44, height: 44)
                                        .colorMultiply(.tabBarBackground2)
                                        .padding(.top, 7)
                                    
                                }
                        }
                }
            
            
            
            // MARK: Tab Items
            HStack {
                // MARK: Expand Button
                
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                // MARK: Navigation Button
                
                NavigationLink {
                    Text("Detalle")
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }

            }
            .font(.title2)
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
            
            

        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    
    }
}

#Preview {
    TabBar(action: {})
        .preferredColorScheme(.dark)
}
