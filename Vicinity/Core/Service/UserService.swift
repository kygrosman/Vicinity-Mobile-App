//
//  UserService.swift
//  Vicinity (iOS)
//
//  Created by Madeline Sukhdeo on 7/25/22.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUserData(withuid uid: String, completion: @escaping(User) -> Void) {
        print("kyle")
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            print("maddykyle")
            guard let snapshot = snapshot else {return}
            print("maddybiz")
            guard let user = try? snapshot.data(as: User.self) else { return }
            print("maddykylebiz")
            completion(user)
        } 
    }
  
}


