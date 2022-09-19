//
//  SideMenuView.swift
//  Vicinity
//
//  Created by Kyle Grosman on 9/11/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @State private var action: Int? = 0
    @State private var signOutAlert = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                
                NavigationLink(destination: EditProfileView(), tag: 1, selection: $action) { EmptyView() }
                NavigationLink(destination: ForgotPassView2(), tag: 2, selection: $action) { EmptyView() }
                
                Group {
                    // edit profile button
                    Button {
                        action = 1
                    } label: {
                        Text("Edit Profile")
                            .foregroundColor(Color("VicinityNavy"))
                    }
                    
                    // reset password button
                    Button {
                        action = 2
                    } label: {
                        Text("Reset Password")
                            .foregroundColor(Color("VicinityNavy"))
                    }
                    
                    // sign out button
                    Button {
                        signOutAlert.toggle()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(Color(.red))
                    }
                    .alert(isPresented: $signOutAlert) {
                        Alert(
                            title: Text("Confirm Sign Out"),
                            message: Text("Are you sure you would like to sign out of your account?"),
                            primaryButton: .default(
                                Text("Cancel")),
                            secondaryButton: .destructive(
                                Text("Sign Out")) {
                                authViewModel.signOut()
                            }
                        )
                    }
                }.padding(.bottom, 20)
                    
                Spacer()
            }
            .padding(.top, 60)
        }
        .padding(.trailing, 30)
        
        
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
