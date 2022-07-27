//
//  ForgotPassView.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI

struct ForgotPassView: View {
    
    @State private var email = ""
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
                        .padding([.bottom], 70.0)
                    
                    
                    // email text field
                    Group {
                        TextField("email", text: $email)
                            .padding(.bottom, 20)
                    }
                    .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)
                    .font(.headline.weight(.bold))
                }.padding(.leading, 50)
                .navigationBarHidden(true)
                .padding(.bottom, 20)
                
                VStack(alignment: .center) {
                    
                    // login button
                    Button(action: {
                        //send new pswrd link
        
                    }, label: {
                        Text("Send Password Reset").fontWeight(.heavy)
                    })
                    .foregroundColor(.white)
                    .frame(width: 256, height: 40, alignment: .center)
                    .background(Color("VicinityNavy"))
                    .cornerRadius(30)
                    .padding(.bottom, 20)
                    
                }
                .navigationBarHidden(true)
            }
            .offset(x: 0, y: -100)
        
    }
}

struct ForgotPassView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassView()
    }
}
