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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
            ZStack {
                
                NavigationLink(destination: LoginView(), tag: 1, selection: $action) { EmptyView() }
                NavigationLink(destination: SignUpView(), tag: 2, selection: $action) { EmptyView() }
                
                Color.white
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Image("VicinityMapBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .center)
                        .ignoresSafeArea()
                        .overlay(
                            Image("VicinityLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 226, height: 69, alignment: .center)
                        )
                }
                .position(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 2.15)
                
                
                VStack {
                    Button(action: {
                        self.action = 1
                    }, label: {
                        Text("Login").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                    
                    Button(action: {
                        self.action = 2
                    }, label: {
                        Text("Sign Up").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                }
                .position(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight * 0.73)
                
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    
}

struct OpenAppView_Previews: PreviewProvider {
    static var previews: some View {
        OpenAppView()
    }
}
