//
//  TabView.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.
//

import SwiftUI

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        TabView {
            //MARK: (페이지 1) 앱 소개
            OnboardingPageView(
                imageName: "person.3.fill",
                title: "QRcode 안전 발급 서비스",
                subtitle: "안전한 QR을 이용하세요."
                    
            )
            //MARK: - (페이지2) 기능1
            OnboardingPageView(
                imageName: "qrcode.viewfinder",
                title: "자체 인증 QR 제공",
                subtitle: "인증된 QR을 제공함으로써 안전하게 QR 접속"
            )
            
            //MARK: - (페이지3) 기능2
            OnboardingLastPageView(
                imageName: "questionmark.key.filled",
                title: "2차 검증 서비스",
                subtitle: "",
                isFirstLaunching: $isFirstLaunching
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
