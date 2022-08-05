//
//  IndividualPostForCommentsView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI

struct IndividualPostForCommentsView: View {
    @ObservedObject var viewModel: IndividualPostViewModel
    @State var comment = "leave a comment..."
    
    init(post: Post) {
        self.viewModel = IndividualPostViewModel(post: post)
        
    }
    
    var body: some View {
        
        IndividualPostView(post: self.viewModel.post, showComment: false).padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
        Spacer()
        
        VStack {
            TextEditor(text: $comment).foregroundColor(.gray)
                .frame(height: 50)
                .overlay(Rectangle().stroke(Color("VicinityNavy"),lineWidth:3))
            Button(action: {
                //post comment
            }, label: {
                Text("post").foregroundColor(.black)
                    .frame(width: 60, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("VicinityNavy"),lineWidth:3))
                
            })
        }.padding(.init(top: 5, leading: 10, bottom: 0, trailing: 10))
        
        ScrollView {
            LazyVStack {
                ForEach(0...5, id: \.self) { _ in
                    IndividualCommentView().padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }
    }
}
