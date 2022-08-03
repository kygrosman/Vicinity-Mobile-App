//
//  ContentView.swift
//  Vicinity
//
//  Created by Kyle Grosman on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("WELCOME!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color("VicinityGold"))
                .padding(.bottom, 15)
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out")
                    .fontWeight(.bold)
                    .foregroundColor(Color("VicinityNavy"))
            })
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
