//
//  ProfileViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/29/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var posts = [Post]()
    let postService = PostService()
    private let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserPosts()
    }
    
    func fetchUserPosts() {
        guard let uid = user.id else {return}
        postService.fetchPostsForUser(forUid: uid) { posts in
            self.posts = posts
        }
    }
    
}
