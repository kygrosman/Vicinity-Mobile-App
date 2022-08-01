//
//  PostingViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/28/22.
//

import Foundation

class PostingViewModel: ObservableObject {
    @Published var didUploadPost = false
    
    
    let service = PostService()
    func uploadPost(withPostbody postbody: String, withType type: String, withDistance distance: String, withCost cost: String, withPlus21 plus21: Bool, withSale sale: Bool, withAnon anon: Bool) {
        service.uploadPost(postbody: postbody, type: type, distance: distance, cost: cost, plus21: plus21, sale: sale, anon: anon) { success in
            if success {
                self.didUploadPost = true
            } else {
                //show error message to user
            }
        }
    }
    
}
