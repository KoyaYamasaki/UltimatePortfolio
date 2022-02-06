//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by 山崎宏哉 on 2022/02/06.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
