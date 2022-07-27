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
    // do a bunch of email validation stuff or phone num validation
    @State private var code = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // navigation links
                VStack(alignment: .leading) {
                    //title
                    Text("Validate Email")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("VicinityNavy"))
                        .multilineTextAlignment(.leading)
                        .padding([.bottom], 70.0)
                    
                    // email text field
                    Group {
                        TextField("code", text: $code)
                            .padding(.bottom, 20)
                            
                    }
                    .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)
                    .font(.headline.weight(.bold))
                }.padding(.leading, 50)
                .navigationBarHidden(true)
                .padding(.bottom, 20)
                
                VStack(alignment: .center) {
                    
                    
                    Button(action: {
                        
                        // validate code
                        // go to home
                        
        
                    }, label: {
                        Text("Enter").fontWeight(.heavy)
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
}

struct ConfirmEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmEmailView()
    }
}
