//
//  SplashView.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Spacer()
            
            VStack {
                Image("logo2")
                    .font(.system(size: 100))
                    .foregroundColor(.black)
                
                Spacer()
                    .frame(height: 30)
                Text("1등하면 주임님이랑 회식함")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
            
        }
    }
}
