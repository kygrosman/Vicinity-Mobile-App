//
//  ForgotPassView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import NavigationStack

struct ForgotPassView: View {
    
    @State private var action: Int? = 0
    @State private var email = ""
    @State private var showAlert = false
    @State private var error_msg = ""
    @State private var error_title = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            
            VStack {
                // navigation links
                VStack(alignment: .leading) {
                    //title
                    Text("Forgot Password")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("VicinityNavy"))
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 30)
                    
                    Text("Enter your email below and shortly after you will receive a link to reset your password")
                        .padding([.trailing], 65)
                        .foregroundColor(Color("VicinityNavy"))
                        .padding(.bottom, 20)
                        
                    
                    // email text field
                    Group {
                        TextField("email", text: $email)
                            .padding([.bottom, .trailing], 15)
                    }
                    .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)
                    .font(.headline.weight(.bold))
                }.padding(.leading, 50)
                .padding(.bottom, 20)
                
                VStack(alignment: .center) {
                    
                    // login button
                    Button(action: {
                        //send new pswrd link
                        let reset = viewModel.resetPass(email: email)
                        if (reset[0] as! Bool == false)
                        {
                            error_title = "Unable to Send Email"
                            error_msg = reset[1] as! String
                            showAlert = true
                        }
                        else {
                            error_title = "Password Reset Sent"
                            error_msg = "Check your email for a password reset link"
                            showAlert = true
                        }
                        
                        
                    }, label: {
                        Text("Send Password Reset").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40, alignment: .center)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                    .padding(.bottom, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Unable to send email"), message: Text(error_msg))
                    }
                    
                }
            }
            .offset(x: 0, y: -100)
        }
    }

struct ForgotPassView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassView()
    }
}
