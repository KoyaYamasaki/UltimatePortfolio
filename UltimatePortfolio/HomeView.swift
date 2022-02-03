//
//  HomeView.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/01/08.
//

import SwiftUI

struct HomeView: View {
    // The type is corresponding to SceneStorage "selectedView"(String?).
    static let tag: String? = "Home"

    @EnvironmentObject var dataController: DataController
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
