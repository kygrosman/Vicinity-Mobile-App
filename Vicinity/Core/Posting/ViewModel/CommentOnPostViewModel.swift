//
//  CommentOnPostViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/5/22.
//

import Combine

class CommentOnPostViewModel: ObservableObject {
    let postService = PostService()
    
    func postComment(post: Post, comment: String) -> Bool {
        postService.postComment(post, comment) { posted in
            return posted
        }
        return false
    }
    
}
