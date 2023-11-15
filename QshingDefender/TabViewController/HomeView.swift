//
//  HomeViewController.swift
//  QshingDefender
//
//  Created by 박경호 on 11/14/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("기능 선택").padding(.top) ) { // 섹션의 헤더에 패딩을 추가하여 상단 여백을 만듭니다.
                    NavigationLink(destination:FeatureOneView() ) {
                        FeatureRow(title: "QR 스캐너", iconName: "star")
                    }
                    NavigationLink(destination: SettingView()) {
                        FeatureRow(title: "설정", iconName: "heart")
                    }
                }
                .headerProminence(.increased) // 헤더의 중요도를 높여 시각적 거리를 더 늘립니다.
            }
            .navigationTitle("홈 화면")
        }
        
    }
}

struct FeatureRow: View {
    var title: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
            Text(title)
        }
    }
}

struct FeatureOneView: View {
    var body: some View {
        Text("기능 1 화면")
    }
}

struct FeatureTwoView: View {
    var body: some View {
        Text("기능 2 화면")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
