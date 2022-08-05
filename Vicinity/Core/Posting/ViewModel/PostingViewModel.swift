//
//  PostingViewModel.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 7/28/22.
//

import Foundation
import UIKit

class PostingViewModel: ObservableObject {
    @Published var didUploadPost = false
    
    
    let service = PostService()
    func uploadPost(withPostbody postbody: String, withType type: String, withDistance distance: String, withCost cost: String, withPlus21 plus21: Bool, withSale sale: Bool, withAnon anon: Bool, im: UIImage?) -> Bool  {
        
        if postbody == "" ||
        type == "TYPE" ||
        cost == "COST" ||
        distance == "DISTANCE"{
            return false 
        }
        
        var imageURL = ""
        if im != nil {
            print("ahh")
            let currentImage = im!
            ImageUploader.uploadImage(image: currentImage) { returnedImageURL in
                print(returnedImageURL)
                imageURL = returnedImageURL
            }
        }
        
        service.uploadPost(postbody: postbody, type: type, distance: distance, cost: cost, plus21: plus21, sale: sale, anon: anon, imageURL: imageURL) { success in
            if success {
                self.didUploadPost = true
            } else {
                return false
            }
            return true
        }
        return true
    }
    
}
