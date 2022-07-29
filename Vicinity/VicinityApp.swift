//
//  VicinityApp.swift
//  Vicinity
//
//  Created by Kyle Grosman on 7/27/22.
//

import SwiftUI
import Firebase
import NavigationStack

@main
struct VicinityApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()

        
        print("DEBUG -- User Session UID: \(String(describing: viewModel.userSession?.uid))")
        print("DEBUG -- Email Verification: \(String(describing: viewModel.userSession?.isEmailVerified))")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{

                if (viewModel.userSession == nil && viewModel.userSession?.isEmailVerified == true)
                {
                    OpenAppView()
                }
                else if (viewModel.userSession?.isEmailVerified == false)
                {
                    ConfirmEmailView()
                }
                else {
                    HomeView()
                }
            }
            .environmentObject(viewModel)
        }
    }
}
