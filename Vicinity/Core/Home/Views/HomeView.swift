//
//  HomeView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI
import PopupView

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var showPostPopUp = false
    @State var selectedTab = 0
    @State private var postAction: Int? = 0
    
    // PROFILE SIDE MENU VARIABLES
    // show variable is authViewModel.showProfileSideMenu
    @State var signOutAlert = false
    @State private var profileAction: Int? = 0
    
    /*
     
     WHEN ADDING NEW TAB ITEMS:
        - add image name to the tabBarImageNames array
        - add case for the switch statement (what view it goes to)
     
     ezpz
     
     */
    
    let tabBarImageNames = ["house.fill", "plus.app.fill", "person.fill"]

    var body: some View {
        ZStack {
            
            // navigate to posting process
            NavigationLink(destination: RecommendView(), tag: 1, selection: $postAction) { EmptyView() }
            NavigationLink(destination: QuestionView(), tag: 2, selection: $postAction) { EmptyView() }
            
            // navigate from profile page
            NavigationLink(destination: EditProfileView(), tag: 1, selection: $profileAction) { EmptyView() }
            NavigationLink(destination: ForgotPassView2(), tag: 2, selection: $profileAction) { EmptyView() }
                
            VStack {
                ZStack{
                    // --- to do
                    // IMPLEMENT SCROLL UP REFRESH WHEEL
                    // ---
                    
                    // switch statement for the page shown
                    switch selectedTab {
                    case 0: // home page
                        HomePageView()
                    case 2: // profile page
                        ProfilePageView(user: authViewModel.currentUser!)
                        //Text("hi")
                    default: //default
                        Text("vicinity in this binity")
                    }
                }
                
                // shoves tab to the bottom
                Spacer()
                
                HStack {
                    // ignore the non-constant range warning, it doesn't matter
                    // i made it non-constant so its easier to add tab items
                    ForEach(0..<tabBarImageNames.count) { num in
                        Button(action: {
                            if tabBarImageNames[num] == "plus.app.fill" {
                                showPostPopUp.toggle()
                            } else {
                                selectedTab = num
                            }
                        }, label: {
                            Spacer()
                            if tabBarImageNames[num] == "plus.app.fill" {
                                Image(systemName: tabBarImageNames[num])
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(Color("VicinityGold"))
                            } else {
                                Image(systemName: tabBarImageNames[num])
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(selectedTab == num ? Color("VicinityNavy") : Color("VicinityBlue"))
                            }
                            Spacer()
                        })
                    }
                }
            }
        }
        // POPUP FOR POSTING PROCESS
        .popup(isPresented: $showPostPopUp, type: .floater(verticalPadding: 15, useSafeAreaInset: true), position: .bottom, closeOnTapOutside: true, backgroundColor: .black.opacity(0.3)) {
            ZStack(alignment: .center) {
                Color
                    .white
                    .frame(width: UIScreen.screenWidth - 30, height: 100)
                    .cornerRadius(30)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        postAction = 2
                    }, label: {
                        Text("Question")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color("VicinityNavy"))
                            .overlay(Capsule(style: .continuous)
                                .stroke(Color("VicinityNavy"), lineWidth: 3))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        postAction = 1
                    }, label: {
                        Text("Recommend")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color("VicinityNavy"))
                            .overlay(Capsule(style: .continuous)
                                .stroke(Color("VicinityNavy"), lineWidth: 3))
                    })
                    
                    Spacer()
                }//.padding(.top, 25)
            }
        }
        // POPUP FOR PROFILE SIDE MENU
        .popup(isPresented: $authViewModel.showProfileSideMenu, type: .floater(verticalPadding: 15, useSafeAreaInset: true), position: .top, closeOnTapOutside: true, backgroundColor: .black.opacity(0.3)) {
            
            ZStack(alignment: .topTrailing) {
                Color
                    .white
                    .frame(width: 200, height: 180/* for full length -- UIScreen.screenHeight-100*/)
                    .cornerRadius(30)
                
                VStack(alignment: .trailing) {
                    
                    Button(action: {
                        profileAction = 1
                    }, label: {
                        Text("Edit Profile")
                            .padding()
                            .foregroundColor(Color("VicinityNavy"))
                    }).padding(.top, 5)
                    
                    Button(action: {
                        profileAction = 2
                    }, label: {
                        Text("Forgot Password")
                            .padding()
                            .foregroundColor(Color("VicinityNavy"))
                    })
                    
                    Button(action: {
                        signOutAlert.toggle()
                    }, label: {
                        Text("Sign Out")
                            .padding()
                            .foregroundColor(.red)
                    })
                }//.padding(.top, 25)
            }.offset(x: UIScreen.screenWidth/6)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

