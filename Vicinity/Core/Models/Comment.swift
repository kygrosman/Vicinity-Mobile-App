//
//  Comment.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/5/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

//comment class
struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let userID: String
    let commentBody: String
    var user: User?
}
