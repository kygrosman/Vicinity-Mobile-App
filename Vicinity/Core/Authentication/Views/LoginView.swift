//
//  LoginView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import FirebaseAuth
import SwiftEmailValidator
import NavigationStack

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var error_msg = ""
    @State private var action = false
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            
        
            
        ZStack {
            NavigationLink(destination: ForgotPassView(), isActive: $action) { EmptyView() }
            
            /*
             RoundedRectangle(cornerRadius: 40)
             .frame(width: 380, height: 430, alignment: .center)
             .foregroundColor(Color("VicinityNavy"))
             .overlay(
             RoundedRectangle(cornerRadius: 30)
             .frame(width: 360, height: 410, alignment: .center)
             .foregroundColor(.white)
             )
             .offset(x: 0, y: -100)
             */
            VStack {
                VStack(alignment: .leading) {
                    
                    //title
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("VicinityNavy"))
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 70.0)
                    
                    // email text field
                    Group {
                        TextField("email", text: $email)
                            .padding(.bottom, 20)
                        
                        
                        // password text field
                        SecureField("password", text: $password)
                            .padding(.bottom, 20)
                        
                    }
                    .disableAutocorrection(true)
                    .dynamicTypeSize(.xxxLarge)
                    .font(.headline.weight(.bold))
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                .padding(.leading, 50)
                .padding(.bottom, 20)
                
                VStack(alignment: .center) {
                    
                    // login button
                    Button(action: {
                        //login
                        let login = viewModel.login(email: email, password: password)
                        if (login[0] as! Bool == false)
                        {
                            error_msg = login[1] as! String
                            showAlert = true
                        } 
                        
                    }, label: {
                        Text("Sign In").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40, alignment: .center)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                    .padding(.bottom, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Unable to log in"), message: Text(error_msg))
                    }
                    
                    //forgot password button
                    Button(action: {
                        print("DEBUG -- PUSH to ForgotPass")
                        self.action.toggle()
                    }, label: {
                        Text("Forgot Password?")
                            .fontWeight(.bold)
                    }).foregroundColor(Color("VicinityNavy"))
                    
                    
                    
                }
                //.navigationBarHidden(true)
            }
            .offset(x: 0, y: -100)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
