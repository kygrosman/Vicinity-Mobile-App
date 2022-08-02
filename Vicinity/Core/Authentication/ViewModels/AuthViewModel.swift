//
//  AuthViewModel.swift
//  Vicinity (iOS)
//
//  Created by Kyle Grosman on 7/25/22.
//

import SwiftUI
import Firebase
import SwiftEmailValidator

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    private let service = UserService()
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG -- User Session: \(String(describing: self.userSession))")
        self.fetchuserData()
    }
    
    
    // LOGIN FUNCTION
    func login(email: String, password: String) -> Array<Any> {
        
        // ----- CHECK IF ALL FIELDS FILLED
        if (email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            // Fill in all cases
            return [false, "Fill in all fields"]
        }
        
        print("DEBUG -- Loggig in")
        var err = false
        var descrip = ""
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG -- Failed to log in user with error: \(error.localizedDescription)")
                
                switch error.localizedDescription {
                case "The password is invalid or the user does not have a password.":
                    descrip = "Invalid password"
                case "The email address is badly formatted.":
                    descrip = "Email is invalid"
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    descrip = "No user with that email"
                default:
                    descrip = "Error logging in"
                }
                
                err = true
                return
            }
            err = false
            guard let user = result?.user else { return }
            self.userSession = user
            //self.fetchuserData()
        }
        print("error")
        if (err) {return [false, descrip]}
        self.fetchuserData()
        return [true, ""]
    }
    
    // -- SINGUP FUNCTION
    func signup(email: String, password: String, username: String, fullname: String) -> Array<Any> {
    
        print("DEBUG: Checking fields")
        
        // ----- CHECK IF ALL FIELDS FILLED
        if (email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            username.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fullname.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            // Fill in all cases
            return [false, "Fill in all fields"]
        }
        
        /*
        //check if email is a JHU emial
        let grabbedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailBool1 = EmailSyntaxValidator.correctlyFormatted(grabbedEmail)
        let emailBool2 = grabbedEmail.contains("jhu.edu")
        let emailBool3 = grabbedEmail.contains("jh.edu")
        
        if !(emailBool1 && (emailBool2 || emailBool3))
        {
            // Email is not a valid JHU email
            return [false, "Email is not a vlid JHU email"]
        }
         */
        
        /*
        //check if password is valid
        let pwTest = NSPredicate(format: "SELF MATCHES %@",
            "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        let pw = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwBool = pwTest.evaluate(with: pw)
        
        if (!pwBool)
        {
            // Password does not meet requirements
            error_msg = "Password too weak"
            return false
        }
         */
        
        print("DEBUG -- Signing up")
        var err = false
        var descrip = ""
    
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG -- Failed to sign up user with error: \(error.localizedDescription)")
                descrip = error.localizedDescription
                err = true
                return
            }
            err = false
            guard let user = result?.user else { return }
            self.userSession = user
            
            let data = [
                "email": email,
                "password": password,
                "fullname": fullname,
                "uid": user.uid,
                "username": username
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG -- User data stored")
                }
            
            print("DEBUG -- New user registered: \(String(describing: self.userSession?.uid))")
            self.fetchuserData()
        }
    
        if (err) {return [false, descrip]}
        self.fetchuserData()
        return [true, ""]
    }
    
    func confirmEmail() {
        print("DEGUB -- Sending Verification Email to: \(String(describing: self.userSession?.email))")
        
        userSession?.sendEmailVerification(completion: { error in
            if let error = error {
                print("DEBUG -- Failed to send email verification with error: \(error.localizedDescription)")
                return
            }
            
            print("DEBUG -- email sent to \(String(describing: self.userSession?.email))")
        })
    }
    
    //signout function
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchuserData() {
        guard let uid = self.userSession?.uid else {return}
        service.fetchUserData(withuid: uid) { user in
            self.currentUser = user
        }
    }
}
