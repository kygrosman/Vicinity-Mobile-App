//
//  PostPageView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import SwiftUI
import Firebase

struct PostPageView: View {
    
    @ObservedObject var postingViewModel = PostingViewModel()
    @State var postBody = "what's in your vicinity..."
    
    @State var expandDistance = false
    @State var textOfDistanceButton = "DISTANCE"
    
    @State var expandEventType = false
    @State var textOfEventTypeButton = "TYPE"

    @State var expandCost = false
    @State var textOfCostButton = "COST"
    
    @State var sale:Bool = false
    @State var plus21:Bool = false
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var importedImage: Image?
    @State private var posted = false
    
    @State private var error_msg = ""
    @State private var showAlert = false

    var body: some View {
        
        VStack() {
            NavigationLink(destination: HomeView(), isActive: $posted) { EmptyView() }

            Text("Recommendation")
                .font(.custom("YesevaOne-Regular",size:30))
                .foregroundColor(Color("VicinityNavy"))
                .offset(y:20)
                .padding(.bottom)
            TextEditor(text: $postBody)
                //.offset(x:30 , y:0)
                .padding()
                .frame(height: 100)
            Spacer()
                //.frame(height:400)
                .frame(height: 4)
            HStack {
                VStack {
                    HStack {
                        Text(textOfEventTypeButton).fontWeight(.heavy).foregroundColor(.orange)
                        Image(systemName: expandEventType ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                            .foregroundColor(.orange)
                    }.onTapGesture {
                        expandEventType.toggle()
                    }
                    if expandEventType {
                        Button(action: {
                            textOfEventTypeButton = "FOOD"
                            expandEventType.toggle()
                        }) {
                            Text("FOOD").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfEventTypeButton = "EVENT"
                            expandEventType.toggle()
                        }) {
                            Text("EVENT").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfEventTypeButton = "SHOP"
                            expandEventType.toggle()
                        }) {
                            Text("SHOP").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfEventTypeButton = "ACTIVITY"
                            expandEventType.toggle()
                        }) {
                            Text("ACTIVITY").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfEventTypeButton = "RESOURCE"
                            expandEventType.toggle()
                        }) {
                            Text("RESOURCE").padding()
                        }.foregroundColor(.black)
                    }
                }.padding()
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.orange,lineWidth: 2))
                
                VStack {
                    HStack {
                        Text(textOfDistanceButton).fontWeight(.heavy).foregroundColor(.blue)
                        Image(systemName: expandDistance ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                            .foregroundColor(.blue)
                    }.onTapGesture {
                        expandDistance.toggle()
                    }
                    if expandDistance {
                        Button(action: {
                            textOfDistanceButton = "WALK"
                            expandDistance.toggle()
                        }) {
                            Text("WALK").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfDistanceButton = "SHUTTLE"
                            expandDistance.toggle()
                        }) {
                            Text("SHUTTLE").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            textOfDistanceButton = "DRIVE"
                            expandDistance.toggle()
                        }) {
                            Text("DRIVE").padding()
                        }.foregroundColor(.black)
                        
                    }
                }.padding()
                    //.background(expand ? Color("VicinityBlue"): Color("VicinityBlue"))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.blue,lineWidth: 2))

                VStack {
                    HStack {
                        Text(textOfCostButton).fontWeight(.heavy).foregroundColor(.green)
                        Image(systemName: expandCost ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                            .foregroundColor(.green)
                    }.onTapGesture {
                        self.expandCost.toggle()
                    }
                    if expandCost {
                        Button(action: {
                            self.textOfCostButton = "$"
                            self.expandCost.toggle()
                        }) {
                            Text("$").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            self.textOfCostButton = "$$"
                            self.expandCost.toggle()
                        }) {
                            Text("$$").padding()
                        }.foregroundColor(.black)
                        
                        Button(action: {
                            self.textOfCostButton = "$$$"
                            self.expandCost.toggle()
                        }) {
                            Text("$$$").padding()
                        }.foregroundColor(.black)
                    }
                }.padding()
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.green,lineWidth: 2))
                
            }
            HStack {
                Button(action: toggleSale){
                    HStack{
                        Image(systemName: sale ? "checkmark.square": "square").foregroundColor(.red)
                        Text("SALE").foregroundColor(Color.red).fontWeight(.heavy)
                    }

                }.padding()
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.red,lineWidth: 2))
                
                Button(action: togglePlus21){
                    HStack{
                        Image(systemName: plus21 ? "checkmark.square": "square").foregroundColor(.black)
                        Text("+21").foregroundColor(Color.black).fontWeight(.heavy)
                    }

                }.padding()
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(.black,lineWidth: 2))
                
            }.padding()
                            
            Button {
                showImagePicker.toggle()
            } label: {
                if let importedImage = importedImage {
                    importedImage.resizable().frame(width: 70, height: 70)
                } else {
                    Image(systemName: "plus.app").resizable().frame(width: 50, height: 50).foregroundColor(Color("VicinityNavy"))
                    Text("Add an Image").fontWeight(.heavy).foregroundColor(.black)
                }
            }.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            Button(action: {
                let p = postingViewModel.uploadPost(
                    withPostbody: postBody,
                    withType: textOfEventTypeButton,
                    withDistance: textOfDistanceButton,
                    withCost: textOfCostButton,
                    withPlus21: plus21,
                    withSale: sale,
                    withAnon: false)
                if p {
                    posted = true
                } else {
                    showAlert = true
                    error_msg = "post must contain body and type, distance, cost selection"
                }
                
            }, label: {
                Text("Post").fontWeight(.heavy).foregroundColor(.black)
                    .frame(width: 300, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("VicinityNavy"),lineWidth:3))
                
            }).padding(.top).alert(isPresented: $showAlert) {
                Alert(title: Text("unable to post"), message: Text(error_msg))
            }
            
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)

    }
    /*}*/
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        importedImage = Image(uiImage: selectedImage)
    }
    
    func toggleSale(){sale = !sale}
    func togglePlus21(){plus21 = !plus21}
    
    /*func uploadImage(_ image: UIImage) {
        ImageUploader.uploadImage()
    } */
}





struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}




//not relevant below!


/*struct costDropdown: View {
    @State var expandCost = false
    @State var textOfCostButton = "COST"
    var body: some View {
        VStack {
            HStack {
                Text(textOfCostButton).fontWeight(.heavy).foregroundColor(.green)
                Image(systemName: expandCost ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    .foregroundColor(.green)
            }.onTapGesture {
                self.expandCost.toggle()
            }
            if expandCost {
                Button(action: {
                    self.textOfCostButton = "$"
                    self.expandCost.toggle()
                }) {
                    Text("$").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfCostButton = "$$"
                    self.expandCost.toggle()
                }) {
                    Text("$$").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfCostButton = "$$$"
                    self.expandCost.toggle()
                }) {
                    Text("$$$").padding()
                }.foregroundColor(.black)
            }
        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.green,lineWidth: 2))

    }
}



struct distanceDropdown: View {
    @State var expandDistance = false
    @State var textOfDistanceButton = "DISTANCE"
    var body: some View {
        VStack {
            HStack {
                Text(textOfDistanceButton).fontWeight(.heavy).foregroundColor(.blue)
                Image(systemName: expandDistance ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    .foregroundColor(.blue)
            }.onTapGesture {
                self.expandDistance.toggle()
            }
            if expandDistance {
                Button(action: {
                    self.textOfDistanceButton = "WALK"
                    self.expandDistance.toggle()
                }) {
                    Text("WALK").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfDistanceButton = "SHUTTLE"
                    self.expandDistance.toggle()
                }) {
                    Text("SHUTTLE").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfDistanceButton = "DRIVE"
                    self.expandDistance.toggle()
                }) {
                    Text("DRIVE").padding()
                }.foregroundColor(.black)
                
            }
        }.padding()
            //.background(expand ? Color("VicinityBlue"): Color("VicinityBlue"))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.blue,lineWidth: 2))

    }
}


struct CheckboxFieldViewSale: View {
    @State var sale:Bool = false
    var title = "SALE"
    func toggleSale(){sale = !sale}
    var body: some View {
        Button(action: toggleSale){
            HStack{
                Image(systemName: sale ? "checkmark.square": "square").foregroundColor(.red)
                Text("SALE").foregroundColor(Color.red).fontWeight(.heavy)
            }

        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.red,lineWidth: 2))
           

    }
}

struct CheckboxFieldViewPlus21: View {
    @State var plus21:Bool = false
    var title = "+21"
    func togglePlus21(){plus21 = !plus21}
    var body: some View {
        Button(action: togglePlus21){
            HStack{
                Image(systemName: plus21 ? "checkmark.square": "square").foregroundColor(.black)
                Text("+21").foregroundColor(Color.black).fontWeight(.heavy)
            }

        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.black,lineWidth: 2))


    }
}
 
 struct eventTypeDropdown: View {
     @State var expandEventType = false
     @State var textOfEventTypeButton = "TYPE"
     var body: some View {
         VStack {
             HStack {
                 Text(textOfEventTypeButton).fontWeight(.heavy).foregroundColor(.orange)
                 Image(systemName: expandEventType ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                     .foregroundColor(.orange)
             }.onTapGesture {
                 self.expandEventType.toggle()
             }
             if expandEventType {
                 Button(action: {
                     self.textOfEventTypeButton = "FOOD"
                     self.expandEventType.toggle()
                 }) {
                     Text("FOOD").padding()
                 }.foregroundColor(.black)
                 
                 Button(action: {
                     self.textOfEventTypeButton = "EVENT"
                     self.expandEventType.toggle()
                 }) {
                     Text("EVENT").padding()
                 }.foregroundColor(.black)
                 
                 Button(action: {
                     self.textOfEventTypeButton = "SHOP"
                     self.expandEventType.toggle()
                 }) {
                     Text("SHOP").padding()
                 }.foregroundColor(.black)
                 
                 Button(action: {
                     self.textOfEventTypeButton = "ACTIVITY"
                     self.expandEventType.toggle()
                 }) {
                     Text("ACTIVITY").padding()
                 }.foregroundColor(.black)
                 
                 Button(action: {
                     self.textOfEventTypeButton = "RESOURCE"
                     self.expandEventType.toggle()
                 }) {
                     Text("RESOURCE").padding()
                 }.foregroundColor(.black)
             }
         }.padding()
             .cornerRadius(20)
             .overlay(RoundedRectangle(cornerRadius: 25).stroke(.orange,lineWidth: 2))
     }
     
     
 }*/

