//
//  User.swift
//  Vicinity (iOS)
//
//  Created by Madeline Sukhdeo on 7/25/22.
//

import FirebaseFirestoreSwift

struct User: Decodable, Identifiable {
    @DocumentID var id: String?
    let username: String
    let password: String
    let phonenum: String
    let email: String
    let profileImageUrl: String?
}
