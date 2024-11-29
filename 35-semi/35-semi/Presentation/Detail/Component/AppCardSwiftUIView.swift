//
//  AppCardSwiftUIView.swift
//  35-semi
//
//  Created by 조성민 on 11/30/24.
//

import SwiftUI

struct AppCardSwiftUIView: View {
    var body: some View {
        
        HStack(alignment: .top) {
            Image(.toss)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.secondary, lineWidth: 0.3)
                )
            
            VStack(alignment: .leading) {
                Text("토스")
                    .font(.title)
                Text("금융이 쉬워진다")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("열기")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    AppCardSwiftUIView()
}
