//
//  PostService.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/28/22.
//

import Firebase

struct PostService {
    
    
    func uploadPost(postbody: String, type: String, distance: String, cost: String, plus21: Bool, sale: Bool, anon: Bool, completion: @escaping(Bool) -> Bool) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid": uid,
                    "postbody": postbody,
                    "type": type,
                    "distance": distance,
                    "cost": cost,
                    "plus21": plus21,
                    "sale": sale,
                    "anon": anon,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        Firestore.firestore().collection("posts").document().setData(data) { error in
            if let error = error {
                print("DEBUG: failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
                
        }
        
    }
    
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts)
            }
    }
    
    func fetchPostsForUser(forUid uid: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func savePost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postID = post.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        userLikesRef.document(postID).setData([:]) {_ in
            completion(true)
        }
    }
    
    func checkIfUserSavedPost(_ post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postID = post.id else {return}

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saved").document(postID).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
    }
    
    func unsavePost(_ post: Post, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postID = post.id else {return}
        guard case post.saved = true else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        userLikesRef.document(postID).delete { _ in
            completion()
        }
    }
    
    func fetchUserSavedPosts(forUid uid: String, completion: @escaping([Post]) -> Void) {
        var posts = [Post]()
        Firestore.firestore().collection("users")
            .document(uid).collection("user-saved")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                documents.forEach { doc in
                    let postID = doc.documentID
                    
                    Firestore.firestore().collection("posts")
                        .document(postID)
                        .getDocument { doc, _ in
                            guard let post = try? doc?.data(as: Post.self) else {return}
                            posts.append(post)
                            completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                        }
                    
                }
            }
    }
    
    
}
