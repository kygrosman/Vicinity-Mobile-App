//
//  Post.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/18/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct Post: Identifiable {
    @DocumentID var id: String?
    var userID: String
    var postBody: String
    var image: UIImage
    var anon: Bool
}
