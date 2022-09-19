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
            VStack {
                Text(comment.commentBody).font(Font.custom("Inter-Italic", size: 18))
                Text("  @" + (comment.user?.username ?? "anon")).foregroundColor(Color("VicinityNavy")).fontWeight(.bold)
            }
        }.padding(.trailing)
        /*
        VStack {
            HStack {
                Circle().frame(width: 20, height: 20).foregroundColor(Color("VicinityBlue"))
                Text("@" + (comment.user?.username ?? "anon") + ":").foregroundColor(Color("VicinityNavy")).fontWeight(.bold)
                Text(comment.commentBody).multilineTextAlignment(.leading).font(Font.custom("Inter-Italic", size: 18))
            }.padding()
        }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 5)) */
        Divider()
    }
    
}

/*struct IndividualCommentView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualCommentView()
    }
}*/
