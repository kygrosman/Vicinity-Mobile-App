//
//  PostService.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/28/22.
//

import Firebase

struct PostService {
    
    
    func uploadPost(postbody: String, type: String, distance: String, cost: String, plus21: Bool, sale: Bool, anon: Bool, completion: @escaping(Bool) -> Void) {
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
}
