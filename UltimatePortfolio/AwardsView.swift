//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/02/16.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"

    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) {  award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(dataController.hasEarned(award: award) ? Color(award.color) : Color.secondary.opacity(0.5))
                        }
                    } //: ForEach
                } //: LazyVGrid
            } //: ScrollView

            .navigationTitle("Awards")
        } //: NavigationView
        .alert(isPresented: $showingAwardDetails) {
            if dataController.hasEarned(award: selectedAward) {
                return Alert(title: Text("Unlocked: \(selectedAward.name)"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Locked: \(selectedAward.name)"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            }
        }
    } //: body
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
