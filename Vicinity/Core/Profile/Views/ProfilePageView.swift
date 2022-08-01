//
//  ProfilePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI
import Firebase

struct ProfilePageView: View {
    @State private var anon = false
    @State private var selectionFilter: PostsFilterViewModel = .mine
    @ObservedObject var profViewModel: ProfileViewModel
    @Namespace var animation
    
    init (user: User) {
        self.profViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
            VStack{
                headerView
                personalInfoView
                Spacer()
                filterBarView
                Spacer()
                //postsView
            }
        }
    }
    
    


/*struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView(user: User(id:"maddy", username: "Mado", fullname: "beepis remington", password: "Mado123", email: "msukhde1@jh.edu", profileImageUrl: ""))
    }
} */


extension ProfilePageView {
    var headerView : some View {
            ZStack(alignment: .bottomLeading){
                VStack(alignment: .leading){
                    Image("Profile Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 40)
                        .position(x:85, y:40)
                        .frame(height:40)
                    HStack{
                        Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                            .padding(.top)
                        Text("\(profViewModel.user.fullname)")
                            .font(.system(size:20))
                            .padding(.top)
                    }
                    .padding()
                }
            
            }

        
    }
        /*ZStack(alignment: .bottomLeading){
            VStack(alignment: .leading){
                Image("Profile Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 40)
                    .offset(x:25, y:20)
                HStack{
                    Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                        .padding(.top)
                    Text("maddy")
                        .padding(.top)
                }
                .padding()
            }
            .offset(x:-90)
        } */
    
    var personalInfoView: some View{
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Username").font(.system(size:15)).foregroundColor(Color.gray)
                Text("@\(profViewModel.user.username)").font(.system(size:20))
            }
            
            VStack(alignment: .leading) {
                Text("Email").font(.system(size:15)).foregroundColor(Color.gray)
                Text("\(profViewModel.user.email)").font(.system(size:20))
            }
            .padding(.top)
            
                
        }
        .position(x: 110, y: 60)
        .frame(height: 130)
        
    }
    
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
        }
        .overlay(Divider().offset(x:0,y:20))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profViewModel.posts(forFilter: self.selectionFilter)) {post in
                    IndividualPostView(post: post).padding()
                }
            }
        }

    }
    
}
