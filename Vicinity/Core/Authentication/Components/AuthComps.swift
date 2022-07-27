//
//  AuthComps.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/26/22.
//

import SwiftUI

struct AuthRoundedBorder: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        
        return Path(path.cgPath)
    }
}
