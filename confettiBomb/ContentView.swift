//
//  ContentView.swift
//  confettiBomb
//
//  Created by Daniel Tille on 31.07.24.
//

import SwiftUI

// Hauptansicht
struct ContentView: View {
    @State private var showPopup = false
    
    var body: some View {
        ZStack {
            Button(action: {
                withAnimation {
                    showPopup = true
                }
            }) {
                Text("Show Popup")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if showPopup {
                PopupView(isPresented: $showPopup)
                    .zIndex(1) // Ensure the popup is above other content
            }
        }
    }
}

// Vorschau-Provider
#Preview {
    ContentView()
}
