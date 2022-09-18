//
//  CommentOnPostViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/5/22.
//

import Foundation
import UIKit

class CommentOnPostViewModel: ObservableObject {
    @Published var comments = [Comment]()
    let postService = PostService()
    
    init(post: Post) {
        _ = fetchComments(post: post)
    }
    
    func postComment(post: Post, comment: String) -> Bool {
        postService.postComment(post, comment) { posted in
            //print("debuginggin", posted)
            //print("debugging more", post.numComments)
            return posted
        }
        return false
    }
    
    func fetchComments(post: Post) ->  [Comment] {
        postService.fetchComments(post) { comments in
            //print("bizzle", post)
            print("maddy", post, comments.count)
            self.comments = comments
            return comments
            
        }
        self.comments = []
        return []
    }
    
    
}
