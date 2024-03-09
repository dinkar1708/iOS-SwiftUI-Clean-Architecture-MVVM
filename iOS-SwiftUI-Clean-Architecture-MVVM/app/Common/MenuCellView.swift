//
//  MenuCellView.swift
//  Shared
//
//  Created by Dinakar Maurya on 2021/07/26.
//
import SwiftUI

struct MenuCellView: View {
    var systemIcon: String
    var text: String
    var body: some View {
        HStack {
            Image(systemName: systemIcon)
                .imageScale(.large)
            Text(text)
                .font(.headline)
        }
        .foregroundColor(.gray)
        .padding(20)
    }
}

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            MenuCellView(systemIcon: "house.circle", text: "Home")
            MenuCellView(systemIcon: "person", text: "Profile")
            MenuCellView(systemIcon: "cart.circle", text: "Cart")
            NavigationLink(destination: MyOrdersView(viewModel: MyOrdersViewModel()),
                           label: {
                            MenuCellView(systemIcon: "folder.badge.person.crop", text: "MyOrders")
                           })
            MenuCellView(systemIcon: "gear", text: "Settings")
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
