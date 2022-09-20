//
//  HomeView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let user = authViewModel.currentUser {
                TabView {
                    HomePageView().tabItem{
                        Text("Home")
                        Image(systemName: "house")
                    }
                    
                    PostPageView().tabItem{
                        Text("Post")
                        Image(systemName: "plus")
                    }
                    
                    ProfilePageView(user: user).tabItem{
                        Text("Profile")
                        Image(systemName: "person")
                    }
                }.onAppear{
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            } else {
                TabView {
                    HomePageView().tabItem{
                        Text("Home")
                        Image(systemName: "house")
                    }
                    
                    PostPageView().tabItem{
                        Text("Post")
                        Image(systemName: "plus")
                    }
                    
                }.onAppear{
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)

            }
            
            // black background between main screen and side menu
            if authViewModel.showMenu {
                ZStack {
                    Color(.black)
                        .opacity(authViewModel.showMenu ? 0.25 : 0.0)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        authViewModel.showMenu = false
                    }
                }
            }
            
            // show side menu
            SideMenuView()
                .offset(x: authViewModel.showMenu ? 0 : 300)
                .frame(width: 230, height: UIScreen.screenHeight)
                .background(authViewModel.showMenu ? Color.white : Color.clear)
                
        }
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
