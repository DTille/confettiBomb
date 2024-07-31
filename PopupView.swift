//
//  PopupView.swift
//  confettiBomb
//
//  Created by Daniel Tille on 31.07.24.
//

import SwiftUI

// Popup-View
struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            
            VStack(spacing: 20) {
                Text("This is a Popup")
                    .font(.title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Text("Dismiss")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(width: 300, height: 200)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .transition(.scale)

            ParticleEffectView(duration: 5)
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false) // Allow interactions to pass through
                .transition(.opacity)
                .zIndex(0) // Partikeleffekte hinter dem Popup anzeigen
        }
    }
}


#Preview {
    PopupView(isPresented: .constant(true))
}
