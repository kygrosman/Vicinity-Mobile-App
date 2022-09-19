//
//  CommentOnPostViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/5/22.
//

import Foundation
import UIKit

class CommentOnPostViewModel: ObservableObject {
    let postService = PostService()
    
    func postComment(post: Post, comment: String) -> Bool {
        postService.postComment(post, comment) { posted in
            print("debuginggin", posted)
            return posted
        }
        return false
    }
    
    func fetchComments(post: Post) -> [Comment] {
        postService.fetchComments(post) { comments in
            print("maddy", comments)
            return comments 
        }
        return []
    }
    
}
