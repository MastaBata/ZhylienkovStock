//
//  ZhylienkovStockApp.swift
//  ZhylienkovStock
//
//  Created by Oleksii Zhylienkov on 14/06/24.
//

import SwiftUI

@main
struct ZhylienkovStockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(AlertViewModel())
            .environmentObject(AppStateStorage())
        }
    }
}
