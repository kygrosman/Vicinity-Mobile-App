//
//  ProfileViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/29/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var savedPosts = [Post]()
    let postService = PostService()
    let userService = UserService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserPosts()
        self.fetchUserSavedPosts()
    }
    
    func posts(forFilter filter: PostsFilterViewModel) -> [Post] {
        switch filter {
        case .mine:
            return posts
        case .saved:
            return savedPosts
        case .getFeedback:
            return posts
        }
    }
    
    func fetchUserPosts() {
        guard let uid = user.id else {return}
        postService.fetchPostsForUser(forUid: uid) { posts in
            self.posts = posts
            for i in 0 ..< posts.count {
                self.posts[i].user = self.user
            }
            
        }
        
    }
    
    func fetchUserSavedPosts() {
        guard let uid = user.id else {return}
        postService.fetchUserSavedPosts(forUid: uid) { posts in
            self.savedPosts = posts
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                self.userService.fetchUserData(withuid: uid) { user in
                    self.savedPosts[i].user = user
                }
            }

        }
    }
    
}
