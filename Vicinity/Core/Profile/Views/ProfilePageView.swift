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
    @State private var anon = false
    @State private var selectionFilter: PostsFilterViewModel = .mine
    @State var showMenu = false
    @ObservedObject var profViewModel: ProfileViewModel
    @Namespace var animation
    
    init (user: User) {
        self.profViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack{
                Group {
                    headerView
                    personalInfoView.padding(.bottom, 45)
                }
                .padding(.leading, 10)
                
                Spacer()
                filterBarView
                Spacer()
                postsView
            }//.navigationBarTitleDisplayMode(.inline)
            .padding(.top, 50)
            
            if showMenu {
                ZStack {
                    Color(.black)
                        .opacity(0.25)
                }.onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
            }
            
            SideMenuView()
                .offset(x: showMenu ? 0: 300)
                .frame(width: 200, height: UIScreen.screenHeight)
                .background(showMenu ? Color.white : Color.clear)
                
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 30)
    }
}
    
    

extension ProfilePageView {
    var headerView : some View {
        //ZStack(alignment: .bottomLeading){
            VStack(alignment: .leading){
                HStack {
                    Image("Profile Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 40)
                        .position(x: UIScreen.screenWidth - 330, y:UIScreen.screenHeight - 860)
                        .frame(height:40)
                    
                    // side menu button
                    Button {
                        showMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(Color("VicinityNavy"))
                    }.padding([.top, .trailing], 30)
                }
                
                HStack{
                    if (profViewModel.user.profileImageUrl != "") {
                        KFImage(URL(string: profViewModel.user.profileImageUrl!))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    } else {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("VicinityBlue"))
                            .padding(.top)
                            .padding(.trailing)
                    }
                    
                    Text("\(profViewModel.user.fullname)")
                        .font(.system(size:20))
                        .padding(.top)
                }
                .padding()
            }
        //}
    }
    
    var personalInfoView: some View{
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size:15))
                    .foregroundColor(Color.gray)
                Text("@\(profViewModel.user.username)")
                    .font(.system(size:20))
            }
            
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.system(size:15))
                    .foregroundColor(Color.gray)
                Text("\(profViewModel.user.email)")
                    .font(.system(size:20))
            }
            .padding(.top)
            
                
        }
        .padding()
        .position(x: 150, y: 60)
        .frame(height: 80)
        
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
        }.padding(.top, 14)
        .overlay(Divider().offset(x:0,y: 28))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(profViewModel.posts(forFilter: self.selectionFilter)) {post in
                    IndividualPostView(post: post, showComment: true).padding()
                }
            }
        }

    }
    
}


// --------------------------------------------
// TEST PROFILE VIEW
// --------------------------------------------

struct Test_ProfilePageView: View {
    @State private var anon = false
    @State private var selectionFilter: PostsFilterViewModel = .mine
    @State private var showMenu = false
    //@ObservedObject var profViewModel: ProfileViewModel
    @Namespace var animation
    
    /*
    init (user: User) {
        self.profViewModel = ProfileViewModel(user: user)
    }
     */
    
    var body: some View {
            VStack{
                headerView
                personalInfoView.padding(.bottom)
                Spacer()
                filterBarView
                Spacer()
                postsView
                
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(0.25)
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                }
                
                SideMenuView()
                    .offset(x: showMenu ? 0: 300)
                    .frame(width: 200)
                    .background(showMenu ? Color.white : Color.clear)
                
            }//.navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
    }
    
    

extension Test_ProfilePageView {
    var headerView : some View {
            ZStack(alignment: .topTrailing){
                VStack(alignment: .leading){
                    HStack {
                        Image("Profile Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 40)
                            .position(x: UIScreen.screenWidth - 330, y:UIScreen.screenHeight - 860)
                            .frame(height:40)
                        Button {
                            showMenu.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(Color("VicinityNavy"))
                        }.padding([.top, .trailing], 30)
                        //.position(x: UIScreen.screenWidth - 300, y:UIScreen.screenHeight - 840)
                        
                    }
                    
                    HStack{
                        Circle().frame(width: 100, height: 100).foregroundColor(Color("VicinityBlue"))
                            .padding(.bottom,20)
                    }
                    .padding([.top, .leading], 30)
                }
            }
    }
    
    var personalInfoView: some View{
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size:15))
                    .foregroundColor(Color.gray)
                Text("@Test_Username")
                    .font(.system(size:20))
            }
            
            VStack(alignment: .leading) {
                Text("Email").font(.system(size:15)).foregroundColor(Color.gray)
                Text("test@jhu.edu").font(.system(size:20))
            }
            .padding([.top, .bottom])
            
                
        }
        .padding()
        .position(x: UIScreen.screenWidth - 300, y: UIScreen.screenHeight - 840)
        .frame(height: 80)
        
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
        }.padding(.top, 40)
        .overlay(Divider().offset(x:0, y:40))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                /*
                ForEach(profViewModel.posts(forFilter: self.selectionFilter)) {post in
                    IndividualPostView(post: post).padding()
                 */
                }
            }
        }
    }
    

struct ProfilePageView_Previews: PreviewProvider {
    //@EnvironmentObject static var authViewModel: AuthViewModel
    static var previews: some View {
        //ProfilePageView(user: authViewModel.currentUser!)
        Test_ProfilePageView()
    }
}
