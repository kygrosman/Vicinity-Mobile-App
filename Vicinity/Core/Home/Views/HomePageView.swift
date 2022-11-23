//
//  HomePageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/14/22.
//  Updated 11/20/22, using code written by Kyle Grosman in RecommendView on 11/12/22
//

import SwiftUI

struct HomePageView: View {

    @State var chosenTags = ["TYPE","COST","DISTANCE"]
    
    @State var showClearFilterButton: Bool = false
    
    @ObservedObject var homePageViewModel : HomePageViewModel = HomePageViewModel(type: "", cost: "", distance: "")
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let tagMap = [
        tags(name: "type", options: ["FOOD","EVENT","SHOP","ACTIVITY","RESOURCE"]),
        tags(name: "cost", options: ["FREE","$","$$","$$$"]),
        tags(name: "distance", options: ["WALK","SHUTTLE","DRIVE"])
    ]

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                Image("vicinity-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 132, height: 40)
                    //.offset(x:-110, y:7)
                    .padding(.leading, 20)
                
            }.padding(.bottom, 5)
            
            HStack {
                //Spacer()
                
                /*
                 i tried using nested ForEach loops so i wouldn't have to
                 use multiple menu options like below, but the compiler
                 kept getting mad for excessive compile times. The issue
                 might be because of data inconsitency, but i'm sick and
                 don't want to debug that
                */
                
                // type menu
                Menu {
                    ForEach(0..<tagMap[0].options.count) { option in
                        Button(action: {
                            chosenTags[0] = tagMap[0].options[option]
                            self.update(type: chosenTags[0], distance: "", cost: "")
                            self.showClearFilterButton = true
                        }, label: {
                            Text(tagMap[0].options[option])
                        })
                    }
                } label : {
                    HStack {
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.orange)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.leading, 10)
                        Spacer()
                        Text(chosenTags[0])
                            .fontWeight(.bold)
                            .foregroundColor(chosenTags[0]=="TYPE" ? .black : .orange)
                            .padding(.trailing, 10)
                        Spacer()
                            
                    }
                    .frame(width: 159, height: 40)
                    .overlay(Capsule(style: .continuous)
                        .stroke(.orange, lineWidth: 3))
                }.padding(.leading, 20)
                
                // cost menu
                Menu {
                    ForEach(0..<tagMap[1].options.count) { option in
                        Button(action: {
                            chosenTags[1] = tagMap[1].options[option]
                            self.update(type: "", distance: "", cost: chosenTags[1])
                            self.showClearFilterButton = true
                        }, label: {
                            Text(tagMap[1].options[option])
                        })
                    }
                } label : {
                    HStack {
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.green)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.leading, 10)
                        Spacer()
                        Text(chosenTags[1])
                            .fontWeight(.bold)
                            .foregroundColor(chosenTags[1]=="COST" ? .black : .green)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    .frame(width: 129, height: 40)
                    .overlay(Capsule(style: .continuous)
                        .stroke(.green, lineWidth: 3))
                }.padding(.leading, 10)
                
                Spacer()
            }.padding(.leading, 0)
            
            HStack {
                //Spacer()
                // distance menu
                Menu {
                    ForEach(0..<tagMap[2].options.count) { option in
                        Button(action: {
                            chosenTags[2] = tagMap[2].options[option]
                            self.update(type: "", distance: chosenTags[2], cost: "")
                            self.showClearFilterButton = true
                        }, label: {
                            Text(tagMap[2].options[option])
                        })
                    }
                } label : {
                    HStack {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.leading, 10)
                        Spacer()
                        Text(chosenTags[2])
                            .fontWeight(.bold)
                            .foregroundColor(chosenTags[2]=="DISTANCE" ? .black : .blue)
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    .frame(width: 177, height: 40)
                    .overlay(Capsule(style: .continuous)
                        .stroke(.blue, lineWidth: 3))
                }
                
                Spacer()
                
                if showClearFilterButton {
                    Button {
                        chosenTags = ["TYPE","COST","DISTANCE"]
                        self.update(type: "", distance: "", cost: "")
                        
                    } label: {
                        Text("clear chosen filter")
                            .foregroundColor(.red)
                    }
                    .frame(width: 177, height: 40)
                        .overlay(Capsule(style: .continuous)
                            .stroke(.red, lineWidth: 3))
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 20)
            
            
            
            
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(homePageViewModel.posts) {post in
                        IndividualPostView(post: post, showComment: true).padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        /*
                         This ZStack acts as the divider between posts
                        
                         It's three rectangles manipaulted to make it look
                         like each post is layered on top of a background,
                         and then layered on a white rectangle, but really
                         they're just divided by some funky shapes
                         */
                        ZStack(alignment: .top) {
                            Rectangle()
                                .foregroundColor(Color("VicinityBlue"))
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .padding(.top, 5)
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .offset(y: -40/2)
                                .clipped()
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.screenWidth, height: 40)
                                .offset(y: 40/2)
                                .clipped()
                                .padding(.top, 10)
                        }
                    }
                }
            }
            
            
            

        }.navigationBarTitleDisplayMode(.inline)
    }
    

    func update(type: String, distance: String, cost: String) {
        homePageViewModel.fetchPosts(type: type, cost: cost, distance: distance)
    }
}






struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
