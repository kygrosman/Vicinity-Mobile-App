//
//  RecommendView.swift
//  Vicinity
//
//  Created by Kyle Grosman on 11/12/22.
//  Rework of PostPageView by Elizabeth Boroda on 7/18/22

import SwiftUI

struct tags {
    var name: String
    var options: [String]
}

struct choseTags {
    var name: String
    var chosen: String
}

struct RecommendView: View {
    
    @ObservedObject var postingViewModel = PostingViewModel()
    @State var postBody = ""
    
    let tagMap = [
        tags(name: "type", options: ["FOOD","EVENT","SHOP","ACTIVITY","RESOURCE"]),
        tags(name: "cost", options: ["FREE","$","$$","$$$"]),
        tags(name: "distance", options: ["WALK","SHUTTLE","DRIVE"])
    ]
    
    @State var chosenTags = ["TYPE","COST","DISTANCE"]
    
    // sale tag variables
    @State var sale:Bool = false
    @State var plus21:Bool = false
    @State var anon:Bool = false
    
    // image variables
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var importedImage: Image?
    @State private var posted = false
    
    @State private var error_msg = ""
    @State private var showAlert = false
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        importedImage = Image(uiImage: selectedImage)
    }
    
    var body: some View {
            
        ScrollView {
            VStack(alignment: .leading) {
                // recommendation header
                Image("recommend-vicinity")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 209, height: 40)
                    .padding(.leading, 20)
                
                    // post body
                VStack(alignment: .leading) {
                    ScrollView{
                        TextField("What's in your vicinity?", text: $postBody)
                            .padding([.leading, .trailing], 20)
                            .multilineTextAlignment(.leading)
                            .frame(width: UIScreen.screenWidth - 30, height: 160)
                            .offset(y: -60)
                            .clipped()
                    }
                    
                    Image("addtags - vicinity")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 152, height: 40)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                    
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
                    }
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    
                    
                    HStack {
                        //Spacer()
                        
                        Button(action: {
                            sale.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: sale ? "checkmark.circle": "circle")
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(.red)
                                Spacer()
                                Text("SALE")
                                    .foregroundColor(.red)
                                    .fontWeight(.bold)
                                    //.font(Font.system(size: 12))
                                Spacer()
                            }
                        })
                        .padding()
                        .cornerRadius(20)
                        .frame(width: 135, height: 50)
                        .overlay(Capsule(style: .continuous)
                            .stroke(.red, lineWidth: 3))
                        
                        //Spacer()
                        
                        Button(action: {
                            plus21.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: plus21 ? "checkmark.circle": "circle")
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                                Text("21+")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    //.font(Font.system(size: 12))
                                Spacer()
                            }
                        })
                        .padding()
                        .cornerRadius(20)
                        .frame(width: 125, height: 50)
                        .overlay(Capsule(style: .continuous)
                            .stroke(.black, lineWidth: 3))
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .padding(.bottom, 30)
                    
                    
                    Image("addimage-vicinity")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 181, height: 40)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                    
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        if let importedImage = importedImage {
                            importedImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(.clear)
                                        .border(Color("VicinityNavy"), width: 6)
                                        // need a way to have frame of overlay rectangle
                                        // fit the frame of the image
                                )
                            Text("Change Image")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .font(Font.system(size: 17))
                        } else {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("VicinityNavy"))
                            Text("Add an Image")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .font(Font.system(size: 17))
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage)
                    }.padding(.leading, 20)
                    
                    HStack{
                        Spacer()
                        VStack {
                            Button(action: {
                                anon.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: anon ? "checkmark.circle": "circle")
                                        .font(.system(size: 35, weight: .bold))
                                        .foregroundColor(.black)
                                    Text("Post Anonymously")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        //.font(Font.system(size: 12))
                                }
                            })
                            .padding()
                            .cornerRadius(20)
                            .frame(width: 240, height: 60)
                            .overlay(Capsule(style: .continuous)
                                .stroke(.black, lineWidth: 3))
                            
                            Button(action: {
                                let p = postingViewModel.uploadPost(
                                    withPostbody: postBody,
                                    withType: chosenTags[0],
                                    withDistance: chosenTags[2],
                                    withCost: chosenTags[1],
                                    withPlus21: plus21,
                                    withSale: sale,
                                    withAnon: anon,
                                    im: selectedImage)
                                if p {
                                    posted = true
                                } else {
                                    showAlert = true
                                    error_msg = "Your post must contain a body and tags for type, cost, and distance"
                                }
                                
                            }, label: {
                                Text("POST")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 42)
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Unable to post"), message: Text(error_msg))
                            }
                            .background(Color("VicinityNavy"))
                            .cornerRadius(30)
                        }
                        
                        Spacer()
                    }.padding(.top, 20)
                }
            }
        }
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
