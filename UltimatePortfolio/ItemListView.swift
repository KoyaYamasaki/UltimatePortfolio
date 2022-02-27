//
//  ItemListView.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/02/25.
//

import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            itemList
        }
    }

    @ViewBuilder var itemList: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
            .padding(.top)

        ForEach(items, content: singleItem)
    }

    func singleItem(_ item: Item) -> some View {
        NavigationLink(destination: EditItemView(item: item)) {
            HStack(spacing: 20) {
                Circle()
                    .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 3)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading) {
                    Text(item.itemTitle)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if item.itemDetail.isEmpty == false {
                        Text(item.itemDetail)
                            .foregroundColor(.secondary)
                    }
                } //: VStack
            } //: HStack
            .padding()
            .background(Color.secondarySystemGroupedBackground)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
        } //: NavigationLink
    }
}

// struct ItemListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemListView()
//    }
// }
