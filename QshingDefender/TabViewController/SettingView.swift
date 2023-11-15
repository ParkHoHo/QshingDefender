//
//  SettingView.swift
//  QshingDefender
//
//  Created by 박경호 on 11/14/23.
//
import SwiftUI

struct SettingView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false // 사용자 기본 설정에 저장

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("일반 설정")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("다크 모드")
                    }
                }
            }
            .navigationTitle("설정 화면")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .tabItem {
            Image(systemName: "gearshape")
            Text("Setting")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
