//
//  iOS_SwiftUI_Clean_Architecture_MVVMApp.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Created by Dinakar Prasad Maurya on 2020/12/29.
//

import SwiftUI
/**
 SwiftUI App protocol
 The new @main used on a class or struct confirmed to App class to give entry point for your SwiftUI app, and the App will take care of creating all the needed things to start your SwiftUI app so you don’t need to do any extra things or handle things by your self including the platform specific code. Ref https://medium.com/@abedalkareemomreyh/what-is-main-in-swift-bc79fbee741c
 */
@main
struct iOS_SwiftUI_Clean_Architecture_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            AmazonHomeView(viewModel: AmazonHomeViewModel())
        }
    }
}
