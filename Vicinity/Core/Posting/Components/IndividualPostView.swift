//
//  IndividualPostView.swift
//  Vicinity (iOS)
//
//  Created by Elizabeth Boroda on 7/21/22.
//

import SwiftUI
import Firebase
import Kingfisher

struct IndividualPostView: View {
    @ObservedObject var viewModel: IndividualPostViewModel
    @ObservedObject var commentViewModel: CommentOnPostViewModel
    
    @State private var comments = [Comment]()
    @State private var seeFullScreenPost = false
    @State private var showComment: Bool

    
    init(post: Post, showComment: Bool) {
        self.viewModel = IndividualPostViewModel(post: post)
        self.commentViewModel = CommentOnPostViewModel(post: post)
        self.showComment = showComment
    }
    
    var body: some View {
        NavigationLink(destination: IndividualPostForCommentsView(post: viewModel.post), isActive: $seeFullScreenPost) { EmptyView() }
        VStack(alignment: .leading) {
            HStack {
                //photo and username are across the top, horizontally
                Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                /*if (commentViewModel.user?.profileImageUrl == nil) {
                    Circle().frame(width: 56, height: 56).foregroundColor(Color("VicinityBlue"))
                } else {
                    KFImage(URL(string: commentViewModel.user?.profileImageUrl!))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                        .padding(.leading, 30)
                }*/
                Text(viewModel.post.anon ? "anon" : viewModel.post.user?.username ?? "anon")
                Text(convertTimestampIntoString(currTime:viewModel.post.timestamp)).font(.caption).foregroundColor(Color.gray)
                Spacer()
                VStack {
                    Button {
                        viewModel.post.saved ?? false
                        ? viewModel.unsavePost()
                        : viewModel.savePost()
                    } label: {
                        Image(systemName: viewModel.post.saved ?? false ? "bookmark.fill" : "bookmark")
                            .foregroundColor(Color("VicinityBlue"))
                    }
                    if showComment {
                        Button {
                            //self.comments = commentViewModel.fetchComments(post: viewModel.post)
                            seeFullScreenPost = true
                        } label: {
                            Image(systemName: "message")
                                .foregroundColor(Color("VicinityBlue"))
                                .overlay(Text(String(commentViewModel.comments.count)).foregroundColor(.black).font(.system(size: 11)))
                        }.offset(y:3)
                    }
                }
            }
            HStack {
                //tags (between 3 and 5, sale and plus 21 only show up if set to true)
                Text(viewModel.post.type)
                    .font(.subheadline).bold()
                    .frame(width: viewModel.post.type.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)), height: 32)
                    .foregroundColor(.orange)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.orange,lineWidth: 1.5 ))
                Text(viewModel.post.cost)
                    .font(.subheadline).bold()
                    .frame(width: (viewModel.post.cost.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)) * 2), height: 32)
                    .foregroundColor(.green)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.green,lineWidth:1.5))
                if viewModel.post.sale {
                    Text("SALE")
                        .font(.subheadline).bold()
                        .frame(width: 60, height: 32)
                        .foregroundColor(.red)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.red,lineWidth: 1.5))

                }
                Text(viewModel.post.distance)
                    .font(.subheadline).bold()
                    .frame(width: viewModel.post.distance.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)), height: 32)
                    .foregroundColor(.blue)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.blue,lineWidth: 1.5))
                if viewModel.post.plus21 {
                    Text("+21")  .font(.subheadline).bold()
                        .frame(width: 60, height: 32)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black,lineWidth: 1.5))
                }
                
            }.padding()
            
            Text(viewModel.post.postbody).multilineTextAlignment(.leading).font(Font.custom("Inter-Italic", size: 18))
        }
        
        Divider()
    }
    
    func convertTimestampIntoString(currTime: Timestamp) -> String {
        let timeAsDate = currTime.dateValue()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: timeAsDate)
    }

    
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

/*struct IndividualPostView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPostView()
    }
} */
