//
//  VicinityApp.swift
//  Shared
//
//  Created by Kyle Grosman on 7/6/22.
//

import SwiftUI
import Firebase

@main
struct VicinityApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
        viewModel.signOut()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                
                if (viewModel.userSession != nil)
                {
                    HomeView()
                } else {
                    OpenAppView()
                }
            }
            .environmentObject(viewModel)
        }
    }
}
