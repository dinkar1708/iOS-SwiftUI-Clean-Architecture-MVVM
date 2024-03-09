//
//  HomeCellView.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Arnav Maurya on 2024/03/09.
//

import SwiftUI

struct HomeContentView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showMenu = true
            }
        }) {
            VStack {
                MyOrdersView(viewModel: MyOrdersViewModel())
            }
        }
    }
}
