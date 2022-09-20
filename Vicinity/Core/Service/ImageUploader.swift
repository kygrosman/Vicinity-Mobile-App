//
//  ImageUploader.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/24/22.
//

import Firebase
import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, useCase: String, completion: @escaping(String) -> Void) {
        
        //compresses by half (decreases quality of image)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // gets ref info
        let filename = NSUUID().uuidString
        var child = ""
        if (useCase == "PROFILE") { child = "profile_images" }
        else if (useCase == "POST") { child = "post_images" }
        
        // creates ref
        let ref = Storage.storage().reference(withPath: "\(child)/\(filename)")
        //let ref = Storage.storage().reference().child("\(child)/\(filename)")
        
        ref.putData(imageData, metadata: nil) {_, error in
            if let error = error {
                print("DEBUG -- DATA: failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageURL, error in
                if let error = error {
                    print("DEBUG -- DOWNLOAD: failed to get url of image \(error.localizedDescription)")
                    return
                }
                guard let imageURL = imageURL?.absoluteString else {return}
                print(imageURL)
                completion(imageURL)
            }
        }
        
    }
}
