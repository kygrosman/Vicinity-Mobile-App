//
//  IndividualPostForCommentsView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI

struct IndividualPostForCommentsView: View {
    @ObservedObject var viewModel: IndividualPostViewModel
    
    init(post: Post) {
        self.viewModel = IndividualPostViewModel(post: post)
        
    }
    
    var body: some View {
        IndividualPostView(post: self.viewModel.post, showComment: false)
        Spacer()
    }
}

/*struct IndividualPostForCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPostForCommentsView()
    }
} */
