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
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                Image("vicinity-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 132, height: 40)
                    //.offset(x:-110, y:7)
                    .padding(.leading, 20)
                
            }.padding(.bottom, 5)
            
            ScrollView {
                LazyVStack {
                    ForEach(homePageViewModel.posts) {post in
                        IndividualPostView(post: post, showComment: true).padding(.init(top: 2, leading: 10, bottom: 10, trailing: 10)) }
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
