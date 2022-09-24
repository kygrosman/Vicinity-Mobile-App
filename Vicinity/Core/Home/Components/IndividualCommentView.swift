//
//  IndividualCommentView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI

struct IndividualCommentView: View {
    let comment: Comment
    
    init(comment: Comment ) {
        self.comment = comment
    }
    
    var body: some View {
        HStack {
            Circle().frame(width: 30, height: 30).foregroundColor(Color("VicinityBlue"))
            HStack {
                Text("@" + (comment.user?.username ?? "anon")).foregroundColor(Color("VicinityNavy")).fontWeight(.bold)
                Text(comment.commentBody).font(Font.custom("Inter-Italic", size: 18))
            }.multilineTextAlignment(.leading)
        }.padding(.trailing)
        Divider()
    }
    
}

/*struct IndividualCommentView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualCommentView()
    }
}*/
