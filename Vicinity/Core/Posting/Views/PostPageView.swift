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
    @State var postBody = ""
    @State var eventType = ""
    @State var cost = ""
    @State var distance = ""
    @State var sale = false
    @State var plus21 = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var importedImage: Image?
    @State private var posted = false
    

    var body: some View {
        
        VStack() {
            NavigationLink(destination: HomeView(), isActive: $posted) { EmptyView() }

            Text("Recommendation")
                .font(.custom("YesevaOne-Regular",size:30))
                .foregroundColor(Color("VicinityNavy"))
                .offset(y:20).padding(.bottom)
            TextField("What's in your vicinity...", text: $postBody).offset(x:30 , y:0).padding(.top)
            Spacer()
                //.frame(height:400)
                .frame(height: 4)
            HStack {
                eventTypeDropdown()
                distanceDropdown()
                costDropdown()
            }
            HStack {
                CheckboxFieldViewSale()
                CheckboxFieldViewPlus21()
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
                postingViewModel.uploadPost(withPostbody: postBody, withType: "", withDistance: "", withCost: "", withPlus21: true, withSale: true, withAnon: false)
                posted = true
            }, label: {
                Text("Post").fontWeight(.heavy).foregroundColor(.black)
                    .frame(width: 300, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("VicinityNavy"),lineWidth:3))
                
            }).padding(.top)
            
            Spacer()
        }

    }
    /*}*/
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        importedImage = Image(uiImage: selectedImage)
    }
    
    /*func uploadImage(_ image: UIImage) {
        ImageUploader.uploadImage()
    } */
}

struct CheckboxFieldViewSale: View {
    @State var isChecked:Bool = false
    var title = "SALE"
    func toggle(){isChecked = !isChecked}
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square").foregroundColor(.red)
                Text(title).foregroundColor(Color.red).fontWeight(.heavy)
            }

        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.red,lineWidth: 2))
           

    }
}

struct CheckboxFieldViewPlus21: View {
    @State var isChecked:Bool = false
    var title = "+21"
    func toggle(){isChecked = !isChecked}
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square").foregroundColor(.black)
                Text(title).foregroundColor(Color.black).fontWeight(.heavy)
            }

        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.black,lineWidth: 2))


    }
}


struct eventTypeDropdown: View {
    @State var expand = false
    @State var textOfButton = "TYPE"
    var body: some View {
        VStack {
            HStack {
                Text(textOfButton).fontWeight(.heavy).foregroundColor(.orange)
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    .foregroundColor(.orange)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                Button(action: {
                    self.textOfButton = "FOOD"
                    self.expand.toggle()
                }) {
                    Text("FOOD").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "EVENT"
                    self.expand.toggle()
                }) {
                    Text("EVENT").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "SHOP"
                    self.expand.toggle()
                }) {
                    Text("SHOP").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "ACTIVITY"
                    self.expand.toggle()
                }) {
                    Text("ACTIVITY").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "RESOURCE"
                    self.expand.toggle()
                }) {
                    Text("RESOURCE").padding()
                }.foregroundColor(.black)
            }
        }.padding()
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(.orange,lineWidth: 2))
    }
    
    func returnText() -> String {
        return self.textOfButton
    }
}

struct costDropdown: View {
    @State var expand = false
    @State var textOfButton = "COST"
    var body: some View {
        VStack {
            HStack {
                Text(textOfButton).fontWeight(.heavy).foregroundColor(.green)
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    .foregroundColor(.green)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                Button(action: {
                    self.textOfButton = "$"
                    self.expand.toggle()
                }) {
                    Text("$").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "$$"
                    self.expand.toggle()
                }) {
                    Text("$$").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "$$$"
                    self.expand.toggle()
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
    @State var expand = false
    @State var textOfButton = "DISTANCE"
    var body: some View {
        VStack {
            HStack {
                Text(textOfButton).fontWeight(.heavy).foregroundColor(.blue)
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
                    .foregroundColor(.blue)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
                Button(action: {
                    self.textOfButton = "WALK"
                    self.expand.toggle()
                }) {
                    Text("WALK").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "SHUTTLE"
                    self.expand.toggle()
                }) {
                    Text("SHUTTLE").padding()
                }.foregroundColor(.black)
                
                Button(action: {
                    self.textOfButton = "DRIVE"
                    self.expand.toggle()
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


/*struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(85)
        .background(
            //RoundedRectangle(cornerRadius: 20, style: .continuous)
                //.stroke(Color("VicinityBlue"), lineWidth: 3)
        ).padding()
    }
} */


struct PostPageView_Previews: PreviewProvider {
    static var previews: some View {
        PostPageView()
    }
}
