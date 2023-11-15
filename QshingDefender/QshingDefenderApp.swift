//
//  QshingDefenderApp.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.
//

import SwiftUI

@main
struct QshingDefenderApp: App {
    @AppStorage("isDarkMode") var isDarkMode = false

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.colorScheme, isDarkMode ? .dark : .light)
            }
        }
}
