//
//  ProfilePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI
import Firebase
import Kingfisher

// --------------------------------------------
// REAL PROFILE VIEW
// --------------------------------------------

struct ProfilePageView: View {
    
    @State var refreshToggle = false
    @State private var anon = false
    @State private var selectionFilter: PostsFilterViewModel = .mine
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var profViewModel: ProfileViewModel
    @Namespace var animation
    
    init (user: User) {
        self.profViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                headerView.padding(.bottom, 15)
                personalInfoView.padding(.bottom, 45)
            }
            .padding(.leading, 20)
            
            //Spacer()
            filterBarView
            //Spacer()
            postsView
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
    
    

extension ProfilePageView {
    var headerView : some View {
        VStack(alignment: .leading){
            HStack {
                // vicinity profile logo
                Image("Profile Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 40)
                    .padding(.leading, 5)
                    //.padding(.top, 15)
                
                // separates image to left side and button to right side
                Spacer()
                
                // side menu button
                Button {
                    withAnimation(.easeInOut) {
                        authViewModel.showMenu.toggle()
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color("VicinityNavy"))
                }.padding([.trailing], 30)
            }
            
            HStack{
                // KF profile image
                if (profViewModel.user.profileImageUrl == nil) {
                    Circle().frame(width: 100, height: 100).foregroundColor(Color("VicinityBlue"))
                } else {
                    KFImage(URL(string: profViewModel.user.profileImageUrl!))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        //.padding(.leading, 15)
                }
                
                // profile full name
                Text("\(profViewModel.user.fullname)")
                    .font(.system(size:20))
                    .padding(.leading, 15)
                    
            }
            .padding(.top, 15)
        }
    }
    
    var personalInfoView: some View{
        
        VStack(alignment: .leading) {
            
            // profile username
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size:15))
                    .foregroundColor(Color.gray)
                Text("@\(profViewModel.user.username)")
                    .font(.system(size:20))
            }
            
            // profile email
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.system(size:15))
                    .foregroundColor(Color.gray)
                Text("\(profViewModel.user.email)")
                    .font(.system(size:20))
            }
            .padding(.top)
            
                
        }
        .padding(.top, 20)
        //.position(x: 150, y: 60)
        .frame(height: 80)
        
    }
    
    // personal and saved posts
    var filterBarView: some View {
        HStack{
            ForEach(PostsFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.system(size:20))
                        .fontWeight(selectionFilter == item ? .semibold : .regular)
                        .foregroundColor(selectionFilter == item ? Color("VicinityNavy") : Color("VicinityBlue"))
                    
                    if selectionFilter == item {
                        Capsule()
                            .foregroundColor(Color("VicinityNavy"))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture{
                    withAnimation(.easeInOut) {
                        self.selectionFilter = item
                    }
                }
            }
        }.padding(.top, 14)
        .overlay(Divider().offset(x:0,y: 27))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profViewModel.posts(forFilter: self.selectionFilter)) {post in
                    IndividualPostView(post: post, showComment: true).padding(.init(top: 2, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }

    }
    
}
