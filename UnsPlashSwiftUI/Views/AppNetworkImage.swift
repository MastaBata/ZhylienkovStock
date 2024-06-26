//
//  SwiftUIView.swift
//  ZhylienkovStock
//
//  Created by Oleksii Zhylienkov on 14/06/24.
//

import SwiftUI

struct ImageOverlay: View {
    var text: String?
    var body: some View {
        VStack {
            if text != nil {
                ZStack {
                    HStack {
                        Text(text ?? "")
                            .font(.callout)
                            .padding(6)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .background(Color.black)
                .opacity(0.6)
            } else {
                Text("")
            }
        }
    }
}

struct AppNetworkImage: View {
    var imageUrl: String
    var text: String?
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                ZStack {
                    image
                        .imageModifier()
                        .transition(.opacity)
                        .overlay(ImageOverlay(text: text), alignment: .topLeading)
                }
            case .failure(let error):
                Text(error.localizedDescription)
//                .frame(width: 250, height: 300)
            @unknown default:
                ProgressView()
                    .scaledToFit()
                    .frame(width: 250, height: 300)
            }
        }
    }
}

struct AppNetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        AppNetworkImage(imageUrl: "https://images.unsplash.com/photo-1638913660695-b490171d17c9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80", text: "Text").previewLayout(.sizeThatFits)
    }
}
