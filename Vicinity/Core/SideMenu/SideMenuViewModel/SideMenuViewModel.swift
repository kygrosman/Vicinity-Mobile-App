//
//  SideMenuViewModel.swift
//  Vicinity
//
//  Created by Kyle Grosman on 9/11/22.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case editProfile
    case resetPass
    case signOut
    
    var title: String{
        switch self {
        case .editProfile: return "Edit Profile"
        case .resetPass: return "Reset Password"
        case .signOut: return "Sign Out"
        }
    }
}
