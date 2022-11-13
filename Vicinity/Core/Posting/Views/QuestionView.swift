//
//  QuestionView.swift
//  Vicinity
//
//  Created by Kyle Grosman on 11/12/22.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        Text("Questions Coming Soon")
            .fontWeight(.heavy)
            .font(Font.system(size: 30))
            .foregroundColor(Color("VicinityNavy"))
        Text("Stay tuned!")
            .font(Font.system(size: 15))
            .foregroundColor(Color("VicinityNavy"))
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
