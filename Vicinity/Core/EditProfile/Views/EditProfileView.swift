//
//  EditProfileView.swift
//  Vicinity
//
//  Created by Kyle Grosman on 9/17/22.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State private var username = "" //set this equal to current username
    @State private var showImagePicker = false;
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack() {
                header
                content
                
                Button {
                    let newUN = username != authViewModel.currentUser?.username
                    let newPP = selectedImage != nil
                    // change all the updated content into firebase
                    if (newPP && newUN) {
                        //update prof pic
                        authViewModel.updateProfPic(selectedImage!)
                        
                        // update prof details
                        authViewModel.updateProfDetails(username)
                    } else if (newUN) {
                        // update prof details
                        authViewModel.updateProfDetails(username)
                    } else if (newPP) {
                        //update prof pic
                        authViewModel.updateProfPic(selectedImage!)
                    }
                    
                    authViewModel.showMenu.toggle()
                    
                    self.presentation.wrappedValue.dismiss()
                    
                } label: {
                    Text("Save").fontWeight(.heavy)
                }
                .foregroundColor(.white)
                .frame(width: 256, height: 40, alignment: .center)
                .background(Color("VicinityNavy"))
                .cornerRadius(30)
                .padding(.top, 30)
                
                Spacer() // pushes everything up
            }
        }
        //.ignoresSafeArea()
        .navigationBarHidden(false)
    }
}

extension EditProfileView {
    var header : some View {
        VStack{
            Image("Edit_Profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 199, height: 40)
                .position(x: UIScreen.screenWidth - 285, y: UIScreen.screenHeight - 860)
                .frame(height:40)
        }
    }
    
    var content : some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("Profile Photo")
                    .font(.system(size:15).bold())
                    .foregroundColor(Color("VicinityNavy"))
                // make it show the current profile image
                
                // show profile photo in different resolutions
                ZStack(alignment: .leading) {
                    // side by side prof pics
                    HStack(alignment: .bottom) {
                        // 100x100 prof pic
                        VStack(alignment: .leading) {
                            Text("100 x 100")
                                .foregroundColor(Color.black)
                                .opacity(0.5)
                            
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .scaledToFill()
                                    .clipShape(Circle())
                            } else {
                                KFImage(URL(string: (authViewModel.currentUser?.profileImageUrl)!))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                            }
                            
                            //Image()
                        }
                        .padding(.trailing, UIScreen.screenWidth - 400)
                        
                        //50x50 prof pic
                        VStack(alignment: .leading) {
                            Text("50 x 50")
                                .foregroundColor(Color.black)
                                .opacity(0.5)
                            
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFill()
                                    .clipShape(Circle())
                            } else {
                                KFImage(URL(string: (authViewModel.currentUser?.profileImageUrl)!))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                            }
                            
                            //Image()
                        }
                    }
                    .padding(.leading, 20)
                    
                    // gray background rectangle
                    Rectangle()
                        .frame(width: 220, height: 200)
                        .cornerRadius(20)
                        .foregroundColor(Color.gray)
                        .opacity(0.3)
                }
                
                // button to change prof pic
                Button {
                    showImagePicker.toggle()
                } label: {
                    Text("Change Photo").bold()
                }
                .foregroundColor(.white)
                .frame(width: 220, height: 40, alignment: .center)
                .background(Color("VicinityNavy"))
                .cornerRadius(30)
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
            .padding(.top, 30)
            
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size:15).bold())
                    .foregroundColor(Color("VicinityNavy"))
                TextField("", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .onAppear {
                        // set user name to current stored username
                        // fix with database
                        username = authViewModel.currentUser!.username
                    }
            }
            .padding(.top, 30)
            
        }
        .padding(.leading, 30)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

