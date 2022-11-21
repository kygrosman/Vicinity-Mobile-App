//
//  IndividualPostForCommentsView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI

struct IndividualPostForCommentsView: View {
    @ObservedObject var viewModel: IndividualPostViewModel
    @ObservedObject var commentViewModel: CommentOnPostViewModel
    @State var comment = ""
    @State private var p = false
    //@State var comments: [Comment]!
    
    init(post: Post) {
        self.viewModel = IndividualPostViewModel(post: post)
        self.commentViewModel = CommentOnPostViewModel(post: post)
        
    }
    
    var body: some View {
        NavigationLink(destination: HomeView(), isActive: $p) { EmptyView() }
        ScrollView {
            IndividualPostView(post: self.viewModel.post, showComment: false).padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        //IndividualPostView(post: self.viewModel.post, showComment: false).padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
        Spacer()
        
        VStack {
            /*TextEditor(text: $comment).foregroundColor(.gray)
                .frame(height: 50)
                .overlay(Rectangle().stroke(Color("VicinityNavy"),lineWidth:3))*/
            TextField("hi", text: $comment, prompt: Text("    leave a comment"))
                .frame(height: 50)
                .overlay(Rectangle().stroke(Color("VicinityNavy"),lineWidth:3))
            Button(action: {
                let _ = commentViewModel.postComment(post: viewModel.post, comment: comment)
                self.commentViewModel.comments = self.commentViewModel.fetchComments(post: viewModel.post)
                p = true
            }, label: {
                Text("post").foregroundColor(.black)
                    .frame(width: 60, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color("VicinityNavy"),lineWidth:3))
                
            })
        }.padding(.init(top: 5, leading: 10, bottom: 0, trailing: 10))
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(self.commentViewModel.comments) {c in
                    IndividualCommentView(comment: c) }
            }.padding(.leading, 20)
        }
        
    }
}
