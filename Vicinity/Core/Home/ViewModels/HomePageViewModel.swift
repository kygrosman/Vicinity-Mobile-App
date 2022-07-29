//
//  HomePageViewModel.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseAuth


class HomePageViewModel: ObservableObject {
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPosts() { posts in
            self.posts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                self.userService.fetchUserData(withuid: uid) { user in
                    self.posts[i].user = user
                }
            }
            
        }
    }
    
    /*func uploadImageToPost(_ image: UIImage) {
        var userSession: FirebaseAuth.User?
        guard let uuid = userSession?.uid else {return}
        
    } */

    
}

