//
//  IndividualCommentView.swift
//  Vicinity
//
//  Created by Elizabeth Boroda on 8/4/22.
//

import SwiftUI

struct IndividualCommentView: View {    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("@madobado:").foregroundColor(Color("VicinityNavy")).fontWeight(.bold)
                Text("sample comment that can take up a whole line!!").multilineTextAlignment(.leading).font(Font.custom("Inter-Italic", size: 18))
            }.padding(.leading)
        }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 5))
    }
}

struct IndividualCommentView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualCommentView()
    }
}
