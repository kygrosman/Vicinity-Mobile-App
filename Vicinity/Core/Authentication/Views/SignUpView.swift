//
//  SignUpView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import FirebaseAuth
import SwiftEmailValidator
import NavigationStack

struct SignUpView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var error_msg = ""
    @State private var alrt = false
    @State private var action = false
    //@State private var action = false
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack {
            
            // navigation links
            VStack(alignment: .leading) {
                //title
                Text("Sign Up")
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
                    TextField("username", text: $username)
                        .padding(.bottom, 20)
                    
                    //full name
                    TextField("full name", text: $fullname)
                        .padding(.bottom, 20)
                
                    // password text field
                    TextField("password", text: $password)
                        .padding(.bottom, 20)
                    
                }
                .disableAutocorrection(true)
                .dynamicTypeSize(.xxxLarge)
                .font(.headline.weight(.bold))
                .autocapitalization(.none)
                
                
            }.padding(.leading, 50)
                //.navigationBarHidden(true)
                .padding(.bottom, 20)
            
            VStack(alignment: .center) {
                
                // login button
                Button(action: {
                    //login
                    let sign = viewModel.signup(email: email, password: password, username: username, fullname: fullname)
                    if (sign[0] as! Bool)
                    {
                        //viewModel.confirmEmail()
                        //self.action.toggle()
                    }
                    else {
                        error_msg = sign[1] as! String
                        alrt = true
                    }
    
                }, label: {
                    Text("Sign Up").fontWeight(.heavy)
                })
                .foregroundColor(.white)
                .frame(width: 256, height: 40, alignment: .center)
                .background(Color("VicinityNavy"))
                .cornerRadius(30)
                .padding(.bottom, 20)
                .alert(isPresented: $alrt) {
                    Alert(title: Text("Invalid Sign Up"), message: Text(error_msg))
                }
                
                
                
            }
            //.navigationBarHidden(true)
        }
        .offset(x: 0, y: -100)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
