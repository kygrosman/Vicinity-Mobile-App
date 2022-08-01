//
//  IndividualPostViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/30/22.
//

import Foundation

class IndividualPostViewModel: ObservableObject {
    @Published var post: Post
    private let service = PostService()
    
    init(post: Post) {
        self.post = post
        checkIfUserSavedPost()
    }
    
    
    func savePost() {
        service.savePost(post) { res in
            self.post.saved = res
        }
    }
    
    func checkIfUserSavedPost() {
        service.checkIfUserSavedPost(post) { saved in
            self.post.saved = saved
        }
    }
    
    func unsavePost() {
        service.unsavePost(post) {
            self.post.saved = false
        }
    }
    
    
}
