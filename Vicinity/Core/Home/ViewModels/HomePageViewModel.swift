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
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPosts() { posts in
            self.posts = posts
        }
    }
    
    /*func uploadImageToPost(_ image: UIImage) {
        var userSession: FirebaseAuth.User?
        guard let uuid = userSession?.uid else {return}
        
    } */

    
}

