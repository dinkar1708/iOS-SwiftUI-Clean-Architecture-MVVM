//
//  ContentView.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/29.
//

import SwiftUI
/**
 https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app
 */
struct AmazonHomeView: View {
    @ObservedObject var viewModel: AmazonHomeViewModel

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Home")
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

    private func list(of homeModels: [AmazonHome]) -> some View {
        List(homeModels) { model in
            NavigationLink(
                destination: DetailView(),
                label: { HStack { Text(model.name); Text(String(model.price)) }}
            )
        }
    }
}

struct AmazonHomeView_Previews: PreviewProvider {
    static var previews: some View {
        List(AmazonHome.getHomeMockData()) { model in
            NavigationLink(
                destination: DetailView(),
                label: { HStack { Text(model.name); Text(String(model.price)) }}
            )
        }
    }
}
