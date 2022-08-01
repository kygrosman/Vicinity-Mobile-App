//
//  IndividualPostView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/21/22.
//

import SwiftUI

struct IndividualPostView: View {
    @ObservedObject var viewModel: IndividualPostViewModel
    
    init(post: Post) {
        self.viewModel = IndividualPostViewModel(post: post)
    }
    
    var body: some View {
        //each post is a vstack
        VStack(alignment: .leading) {
            HStack {
                //photo and username are across the top, horizontally
                Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                Text(viewModel.post.user?.username ?? "anon")
                Text("2w").font(.caption).foregroundColor(Color.gray)
                Spacer()
                VStack {
                    Button {
                        viewModel.post.saved ?? false
                        ? viewModel.unsavePost()
                        : viewModel.savePost()
                    } label: {
                        Image(systemName: viewModel.post.saved ?? false ? "bookmark.fill" : "bookmark")
                            .foregroundColor(Color("VicinityBlue"))
                    }
                    Button {
                        //action (comment)
                    } label: {
                        Image(systemName: "message")
                            .foregroundColor(Color("VicinityBlue"))
                    }.offset(y:3)
                }
                
            }
            HStack {
                //tags (between 3 and 5, sale and plus 21 only show up if set to true)
                Text("SHOP")
                    .font(.subheadline).bold()
                    .frame(width: 60, height: 32)
                    .foregroundColor(.orange)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.orange,lineWidth: 1.5 ))
                Spacer()
                Text("$")
                    .font(.subheadline).bold()
                    .frame(width: 60, height: 32)
                    .foregroundColor(.green)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.green,lineWidth:1.5))
                Spacer()
                Text("SALE")
                    .font(.subheadline).bold()
                    .frame(width: 60, height: 32)
                    .foregroundColor(.red)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.red,lineWidth: 1.5))
                Spacer()
                Text("SHUTTLE")
                    .font(.subheadline).bold()
                    .frame(width: 90, height: 32)
                    .foregroundColor(.blue)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.blue,lineWidth: 1.5))
                Spacer()
                Text("+21")  .font(.subheadline).bold()
                    .frame(width: 60, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black,lineWidth: 1.5))
            }.padding()
            
            Text(viewModel.post.postbody).multilineTextAlignment(.leading).font(Font.custom("Inter-Italic", size: 18))
        }
        
        Divider()
    }
    
}

/*struct IndividualPostView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPostView()
    }
} */
