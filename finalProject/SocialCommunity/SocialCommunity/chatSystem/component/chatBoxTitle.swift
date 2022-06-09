//
//  chatBoxTitle.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//


import SwiftUI

struct chatBoxTitle: View {
    @EnvironmentObject var viewModel: AppViewModel
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8")
    
    var body: some View {
        let name = viewModel.targetUser.userName
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
        }
        .padding()
    }
}

struct chatBoxTitle_Previews: PreviewProvider {
    static var previews: some View {
        chatBoxTitle()
            .background(Color(.orange))
            .previewLayout(.sizeThatFits)
    }
}


