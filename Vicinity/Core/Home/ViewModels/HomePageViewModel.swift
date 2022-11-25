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

//calls functions in the post service and returns sets of posts
class HomePageViewModel: ObservableObject {
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    var typeString: String
    var costString: String
    var distanceString: String
    
    
    init(type: String, cost: String, distance: String) {
        self.typeString = type
        self.costString = cost
        self.distanceString = distance
        fetchPosts(type: typeString, cost: costString, distance: distanceString)
    }
    
    func fetchPosts(type: String, cost: String, distance: String) {
        if (type == "" && cost == "" && distance == "") {
            service.fetchPosts() { posts in
                self.posts = posts
                for i in 0 ..< posts.count {
                    let uid = posts[i].uid
                    self.userService.fetchUserData(withuid: uid) { user in
                        self.posts[i].user = user
                    }
                }
            }
        } else {
            if (type != "") {
                service.fetchPostsFilteredEventType(forFilteredType: type) { posts in
                    self.posts = posts
                    for i in 0 ..< posts.count {
                        let uid = posts[i].uid
                        self.userService.fetchUserData(withuid: uid) { user in
                            self.posts[i].user = user
                        }
                    }
                }
            } else if (cost != "") {
                service.fetchPostsFilteredCost(forFilteredCost: cost) { posts in
                    self.posts = posts
                    for i in 0 ..< posts.count {
                        let uid = posts[i].uid
                        self.userService.fetchUserData(withuid: uid) { user in
                            self.posts[i].user = user
                        }
                    }
                }
            } else {
                service.fetchPostsFilteredDistance(forFilteredDistance: distance) { posts in
                    self.posts = posts
                    for i in 0 ..< posts.count {
                        let uid = posts[i].uid
                        self.userService.fetchUserData(withuid: uid) { user in
                            self.posts[i].user = user
                        }
                    }
                }
            }

        }

        
    }
    


    
}

