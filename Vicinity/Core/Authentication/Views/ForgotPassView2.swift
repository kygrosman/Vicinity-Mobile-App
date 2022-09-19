//
//  ForgotPassView2.swift
//  Vicinity
//
//  Created by Kyle Grosman on 9/18/22.
//

import SwiftUI
import NavigationStack

struct ForgotPassView2: View {
    
    @State private var action: Int? = 0
    @State private var showAlert = false
    @State private var error_msg = ""
    @State private var error_title = ""
    @State private var tBool = false
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            
        VStack {
                // navigation links
                VStack(alignment: .leading) {
                    //title
                    Text("Reset Password")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("VicinityNavy"))
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 30)
                    
                    Text("Click the reset button to send a password reset link to the following email")
                        .padding([.trailing], 65)
                        .foregroundColor(Color("VicinityNavy"))
                        .padding(.bottom, 20)
                        
                    Text("Email")
                        .font(.system(size:15))
                        .foregroundColor(Color.gray)
                    Text("\(viewModel.currentUser!.email)")
                        .font(.system(size:20))
                    
                }.padding(.leading, 50)
                .padding(.bottom, 20)
                
                VStack(alignment: .center) {
                    
                    // login button
                    Button(action: {
                        //send new pswrd link
                        let reset = viewModel.resetPass(email: viewModel.currentUser!.email)
                        if (reset[0] as! Bool == false)
                        {
                            tBool = true
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
                        Alert(title:
                            Text(error_title),
                            message: Text(error_msg),
                            dismissButton: Alert.Button.default(
                                Text("Ok"),
                                action: {
                                    if (!tBool) {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            )
                        )
                    }
                    
                }
            }
            .offset(x: 0, y: -100)
        }
    }

