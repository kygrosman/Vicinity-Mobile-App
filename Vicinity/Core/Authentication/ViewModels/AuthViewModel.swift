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
        self.fetchUserData()
        print("DEBUG -- User Session: \(self.userSession)")
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
                descrip = error.localizedDescription
                err = true
                return
            }
            err = false
            guard let user = result?.user else { return }
            self.userSession = user
        }
    
        if (err) {return [false, descrip]}
        return [true, ""]
    }
    
    // -- SINGUP FUNCTION
    func signup(email: String, password: String, username: String, phoneNum: String) -> Array<Any> {
    
        print("DEBUG: Checking fields")
        
        // ----- CHECK IF ALL FIELDS FILLED
        if (email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            username.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNum.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            // Fill in all cases
            return [false, "Fill in all fields"]
        }
        
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
        
        let phoneNumTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{3}\\d{3}\\d{4}$")
        let grabbedPN = phoneNum.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumBool = phoneNumTest.evaluate(with: grabbedPN)
        
        if (!phoneNumBool)
        {
            // Phone number invalid
            return [false, "Phone number form is invalid"]
        }
        
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
                print("DEBUG -- xFailed to sign up user with error: \(error.localizedDescription)")
                descrip = error.localizedDescription
                err = true
                return
            }
            err = false
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG -- New user registered: \(self.userSession)")
            
            let data = [
                "email": email,
                "password": password,
                "phonenum": phoneNum,
                "uid": user.uid,
                "username": username
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG -- User data stored")
                }
        }
    
        if (err) {return [false, descrip]}
        return [true, ""]
    }
    
    func confirmEmail(email: String, password: String, username: String, phoneNum: String) {
        
    }
    
    //signout function
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUserData(){
        
        guard let uid = self.userSession?.uid else {return}
        service.fetchUserData(withuid: uid) { user in
            self.currentUser = user
        }
    }

}
