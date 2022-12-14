//
//  UserService.swift
//  Vicinity (iOS)
//
//  Created by Madeline Sukhdeo on 7/25/22.
//

import Firebase
import FirebaseFirestoreSwift

//user service - class relating to fetching data from the users database
struct UserService {
    
    func fetchUserData(withuid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else {return}
            guard let user = try? snapshot.data(as: User.self) else { return }
            completion(user)
        } 
    }
  
}


