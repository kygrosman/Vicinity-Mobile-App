//
//  HomePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/14/22.
//

import SwiftUI

struct HomePageView: View {

    @ObservedObject var homePageViewModel = HomePageViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Image("vicinity-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 145.2, height: 44)
                    .offset(x:-110, y:7)
                
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(homePageViewModel.posts) {post in
                        IndividualPostView(post: post, showComment: true).padding() }
                }
            }

        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
