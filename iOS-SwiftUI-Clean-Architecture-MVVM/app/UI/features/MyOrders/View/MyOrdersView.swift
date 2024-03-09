//
//  MyOrdersView.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/29.
//

import SwiftUI
/**
 https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app
 */
struct MyOrdersView: View {
    @ObservedObject var viewModel: MyOrdersViewModel

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("MyOrders")
        }
        .onAppear { self.viewModel.fetchHomeContent() }
    }

    private var content: some View {
        Group {
            switch viewModel.state {
            case .loading:
                Text("Loading")
            case .error(let error):
                Text(error)
            case .loaded(let homeModels):
                list(of: homeModels)
            }
        }
    }

    private func list(of homeModels: [UserItem]) -> some View {
        List(homeModels) { model in
            NavigationLink(
                destination: OrderDetailsView(),
                label: { HStack { Text(model.name); Text(String(model.price)) }}
            )
        }
    }
}

struct AmazonHomeView_Previews: PreviewProvider {
    static var previews: some View {
        List(UserItem.getHomeMockData()) { model in
            NavigationLink(
                destination: OrderDetailsView(),
                label: { HStack { Text(model.name); Text(String(model.price)) }}
            )
        }
    }
}
