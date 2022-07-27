//
//  HomePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/14/22.
//

import SwiftUI

struct HomePageView: View {

    @ObservedObject var model = HomePageViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading){
                Image("vicinity-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 145.2, height: 44)
                    .offset(x:-110, y:7)
                
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(0...20, id: \.self) {_ in
                        IndividualPostView().padding()
                    }
                }
            }

        }
        /*
        NavigationView {
            
            List(model.posts) { p in
                VStack(alignment: .leading) {
                    Text(p.postBody).font(.headline)
                    Text(p.userID).font(.subheadline)
                }
            }
            
            
        }.onAppear() {
            self.model.fetchData()
        } */
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
