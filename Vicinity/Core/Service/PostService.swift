//
//  PostService.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/28/22.
//

import Firebase

//post service - all functions relating to pulling from posts databases
struct PostService {
    
    //upload post func
    func uploadPost(postbody: String, type: String, distance: String, cost: String, plus21: Bool, sale: Bool, anon: Bool, imageURL: String, completion: @escaping(Bool) -> Bool) {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let data = ["uid": uid,
                    "postbody": postbody,
                    "type": type,
                    "distance": distance,
                    "cost": cost,
                    "plus21": plus21,
                    "sale": sale,
                    "anon": anon,
                    "imageURL": imageURL,
                    "timestamp": Timestamp(date: Date()),
                    "numComments": 0] as [String : Any]

            Firestore.firestore().collection("posts").document().setData(data) { error in
            if let error = error {
                print("DEBUG: failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
                
        }
        
    }
    
    //fetch posts function
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts)
            }
    }
    
    //functions to fetch posts but filtered by something
    func fetchPostsFilteredDistance(forFilteredDistance distanceChoice: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").whereField("distance", isEqualTo: distanceChoice)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchPostsFilteredCost(forFilteredCost costChoice: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").whereField("cost", isEqualTo: costChoice)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchPostsFilteredEventType(forFilteredType typeChoice: String, completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").whereField("type", isEqualTo: typeChoice)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                let posts = documents.compactMap({ try? $0.data(as: Post.self)} )
                completion(posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue() }))
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
    
    func postComment(_ post: Post, _ comment: String, completion: @escaping(Bool) -> Bool) {
        
        //goal for this function:
        //increment numComments counter
        //add comment to collection
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let postID = post.id else {return}
        
        let comment = ["userID": uid, "commentBody": comment, "timestamp": Timestamp(date: Date())] as [String : Any]
        
        let postObj = Firestore.firestore().collection("posts").document(postID)
        
        postObj.updateData(["numComments": (post.numComments ?? 0) + 1]) { err in
            if let err = err {
                print("unable to update number of comments, because \(err)")
            } else {
                print("success!")
            }
            
            postObj.collection("post-comments").document().setData(comment) { error in
            if let error = error {
                print("DEBUG: failed to upload comment with error: \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
            }

        }
        
        
    }
    
    func fetchComments(_ post: Post, completion: @escaping([Comment]) -> [Comment]) {
        var allComments = [Comment]()
        let postNumComments = post.numComments ?? 0
        if postNumComments == 0 {
            return
        }
            
        guard let postID = post.id else {return}
        let postComments = Firestore.firestore().collection("posts").document(postID).collection("post-comments").order(by: "timestamp", descending: true)
        postComments.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            let comments = documents.compactMap({ try? $0.data(as: Comment.self)} )
            comments.forEach({ comment in
                let uidOfCommenter = comment.userID
                Firestore.firestore().collection("users").document(uidOfCommenter).getDocument { doc, _ in
                    guard let commentor = try? doc?.data(as: User.self) else {return}
                    var currentComment = comment
                    currentComment.user = commentor
                    allComments.append(currentComment)
                    completion(allComments)

                }
                completion(allComments)
            })
        }
        
        

    }
    
    
}
