//
//  HomeView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        TabView {
            HomePageView().tabItem{
                Text("Home")
                Image(systemName: "house")
            }
            
            PostPageView().tabItem{
                Text("Post")
                Image(systemName: "plus")
            }
            
            ProfilePageView().tabItem{
                Text("Profile")
                Image(systemName: "person")
            }
        }.onAppear{
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
