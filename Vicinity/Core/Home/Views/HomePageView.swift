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
            
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(homePageViewModel.posts) {post in
                        IndividualPostView(post: post, showComment: true).padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        /*
                         This ZStack acts as the divider between posts
                        
                         It's three rectangles manipaulted to make it look
                         like each post is layered on top of a background,
                         and then layered on a white rectangle, but really
                         they're just divided by some funky shapes
                         */
                        ZStack(alignment: .top) {
                            Rectangle()
                                .foregroundColor(Color("VicinityBlue"))
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .padding(.top, 5)
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .offset(y: -40/2)
                                .clipped()
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .offset(y: 40/2)
                                .clipped()
                                .padding(.top, 10)
                        }
                    }
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
