//
//  IndividualCommentView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI
import Kingfisher


//code to show every individual comment
//gets users profile image and their username, and the comment itself 
struct IndividualCommentView: View {
    let comment: Comment
    
    init(comment: Comment ) {
        self.comment = comment
    }
    
    var body: some View {
        HStack {
            if (comment.user?.profileImageUrl == nil) {
                Circle().frame(width: 30, height: 30).foregroundColor(Color("VicinityBlue"))
            } else {
                KFImage(URL(string: (comment.user?.profileImageUrl!)!))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    //.padding(.leading, 30)
            }
            HStack {
                Text((comment.user?.username ?? "anon")).foregroundColor(Color("VicinityNavy")).fontWeight(.bold)
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
