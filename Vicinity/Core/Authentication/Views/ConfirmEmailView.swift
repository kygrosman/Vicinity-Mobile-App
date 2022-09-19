//
//  ConfirmEmailView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import FirebaseAuth
import SwiftEmailValidator
// https://github.com/MojtabaHs/iPhoneNumberField.git <- phone num formatting

struct ConfirmEmailView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let temp_email = viewModel.userSession?.email ?? "[nil]"
        
        VStack {
            // navigation links
            VStack(alignment: .leading) {
                //title
                Text("Validate Email")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("VicinityNavy"))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 40)
                    .padding(.leading, 35)
                Text("Check your JHU email for a verification link. If you haven't received one, you can resend the email.")
                    .padding([.leading, .trailing], 35)
                    .foregroundColor(Color("VicinityNavy"))
                    .padding(.bottom, 10)
                Text("Email sent to **\(temp_email)**")
                    .padding(.bottom, 5)
                    .foregroundColor(Color("VicinityNavy"))
                    .padding([.leading, .trailing], 35)
                    
            }
            .navigationBarHidden(true)
            .padding(.bottom, 20)
            
            VStack(alignment: .center) {
                
                Button(action: {
                    print("DEBUG -- Sent New Email Verifiction")
                    // validate code
                    // go to home
                    viewModel.confirmEmail()
    
                }, label: {
                    Text("Send New Email").fontWeight(.heavy)
                })
                .foregroundColor(.white)
                .frame(width: 256, height: 40, alignment: .center)
                .background(Color("VicinityNavy"))
                .cornerRadius(30)
                .padding(.bottom, 15)

                
                Button(action: {
                    print("DEBUG -- Signing out from user \(String(describing: viewModel.userSession?.email))")
                    
                    viewModel.signOut()
                }, label: {
                    Text("Not you? Sign out")
                        .fontWeight(.bold)
                }).foregroundColor(Color("VicinityNavy"))
                
            }
            .navigationBarHidden(true)
        }
        .offset(x: 0, y: -100)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.confirmEmail()
        }
        .onReceive(timer) { _ in
            print("DEBUG -- checking if email validated")
            viewModel.reInitUser()
            print("DEBUG -- email verified: \(viewModel.userSession!.isEmailVerified)")
        }
    }
}

struct ConfirmEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmEmailView()
    }
}
