//
//  PostsFilterViewModel.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/22/22.
//

import Foundation
import SwiftUI

enum PostsFilterViewModel: Int, CaseIterable{
    case mine
    case saved
    case getFeedback

    var title: String {
        switch self {
        case .mine: return "Mine"
        case .saved: return "Saved"
        case .getFeedback: return "Ideas?"
        }
    }
}
