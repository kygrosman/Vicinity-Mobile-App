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
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("posts").addSnapshotListener { snapshot, error in
            guard let docs = snapshot?.documents else {
                print("no posts in database")
                return
            }
            self.posts = docs.map { (queryDocumentSnapshot) -> Post in
                let data = queryDocumentSnapshot.data()
                
                let userID = data["userID"] as? String ?? ""
                let postBody = data["postBody"] as? String ?? ""
                let image = data["image"] as? UIImage ?? nil
                return Post(userID: userID, postBody: postBody, image: image!, anon: false)
            }
        }
    }
        
    func addData(userID: String, postBody: String, image: UIImage?) {
        //add a document to the collection
        db.collection("posts").addDocument(data: ["userID":userID, "postBody": postBody, "image": image!]) { error in
            //check for errors
            if error == nil {
                self.fetchData()
            } else {
                //handle the error
            }
        }
        
    }
    
    /*func uploadImageToPost(_ image: UIImage) {
        var userSession: FirebaseAuth.User?
        guard let uuid = userSession?.uid else {return}
        
    } */

    
}

