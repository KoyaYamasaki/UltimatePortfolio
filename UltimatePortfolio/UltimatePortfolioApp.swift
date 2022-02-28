//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/01/06.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController: DataController

    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(
                    // Automatically save when we detect that we are no longer
                    // the foreground app. Use this rather than the scene phase
                    // API so we can port to macOS, where scene phase won't detect
                    // our app losing focus as of macOS 11.1.
                    NotificationCenter.default.publisher(
                        for: UIApplication.willResignActiveNotification
                    ), perform: save)
        }
    }

    func save(_ note: Notification) {
        dataController.save()
    }
}
