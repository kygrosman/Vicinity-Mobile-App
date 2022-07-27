//
//  OpenAppView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import FirebaseAuth
import SwiftEmailValidator

struct OpenAppView: View {
    
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: LoginView(), tag: 1, selection: $action) {
                    EmptyView()
                }
                NavigationLink(destination: SignUpView(), tag: 2, selection: $action) {
                    EmptyView()
                }
                Color.white
                    .ignoresSafeArea()
                VStack {
                    Image("VicinityMapBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 1500)
                        .ignoresSafeArea()
                        .overlay(
                            Image("VicinityLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 226, height: 69)
                        )
                }
                VStack {
                    Button(action: {
                        action = 1
                            
                    }, label: {
                        Text("Login").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                    .padding([.top],450)
                    
                    Button(action: {
                        action = 2
                    }, label: {
                        Text("Sign Up").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                }
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct OpenAppView_Previews: PreviewProvider {
    static var previews: some View {
        OpenAppView()
    }
}
