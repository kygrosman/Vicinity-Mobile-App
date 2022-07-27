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
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        //compresses by half (decreases quality of image)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/post_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) {_, error in
            if let error = error {
                print("DEBUG: failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageURL, error in
                if let error = error {
                    print("DEBUG: failed to get url of image \(error.localizedDescription)")
                    return
                }
                guard let imageURL = imageURL?.absoluteString else {return}
                completion(imageURL)
            }
        }
        
    }
}
