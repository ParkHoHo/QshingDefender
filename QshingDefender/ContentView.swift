//
//  ContentView.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.


import SwiftUI

struct ContentView: View {
    
    @State private var scannedCode: String?
    @State private var showMainView = false

    var body: some View {
            ZStack {
                if showMainView {
                    ThreeTabView()
                } else {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                                withAnimation {
                                    showMainView = true
                                }
                            }
                        }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
