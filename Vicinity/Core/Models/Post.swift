//
//  Post.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let postbody: String
    let type: String
    let distance: String
    let cost: String
    let plus21: Bool
    let sale: Bool
    let anon: Bool
    let timestamp: Timestamp
    
    var user: User? 
}
