//
//  HomeView.swift
//  Shared
//
//  Created by Dinakar Maurya on 2021/07/26.
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

struct HomeView: View {
    @State var showMenu = false
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    HomeContentView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // preivew with menu
        HomeView()
        // preview home view content only
        HomeContentView(showMenu: .constant(true))
    }
}
