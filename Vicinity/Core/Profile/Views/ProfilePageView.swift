//
//  ProfilePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI

struct ProfilePageView: View {
    @State private var anon = false
    @State private var selectionFilter: PostsFilterViewModel = .mine
    @Namespace var animation
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
            headerView
            personalInfoView
            filterBarView
            Spacer()
            postsView
        }
    }
    
    
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
extension ProfilePageView {
    
    var headerView : some View {
        ZStack(alignment: .bottomLeading){
            VStack(alignment: .leading){
                Image("Profile Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 40)
                    .offset(x:25, y:20)
                HStack{
                    Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                        .padding(.top)
                    Text("Maddy Sukhdeo")
                        .padding(.top)
                }
                .padding()
            }
            .offset(x:-90)
        }
    }
    
    var personalInfoView: some View{
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Username").font(.system(size:15)).foregroundColor(Color.gray)
                Text("madobado").font(.system(size:20))
            }
            
            VStack(alignment: .leading) {
                Text("Email").font(.system(size:15)).foregroundColor(Color.gray)
                Text("madelinesukhdeo@gmail.com").font(.system(size:20))
            }.padding(.top)
            
            VStack(alignment: .leading) {
                Text("Anonymous?").font(.system(size:15)).foregroundColor(Color.gray)
                Toggle("", isOn: $anon).labelsHidden()
            }.padding(.top)
                
        }.offset(x:-35)
        
    }
    
    var filterBarView: some View {
        HStack{
            ForEach(PostsFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.system(size:25))
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
        .overlay(Divider().offset(x:0,y:25))
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0...20, id: \.self) {_ in
                    IndividualPostView().padding()
                }
            }
        }

    }
    
}
