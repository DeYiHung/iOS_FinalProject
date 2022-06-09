//
//  chatBox.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI

struct chatBox: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State private var backToProfile = false
    
    
    var body: some View {
        VStack {
            VStack {
                chatBoxTitle()
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(0..<viewModel.messages.count, id: \.self) { index in
                            messageBubble(message: viewModel.messages[index])
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30) // Custom cornerRadius modifier added in Extensions file
                    .onChange(of: viewModel.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            .background(Color(.white))
            
            textFiled()
            
            Button{
                backToProfile = true
            } label:{
                Text("退出")
            }
        }
        .navigate(to: profile(), when: $backToProfile)
    }
}

struct chatBox_Previews: PreviewProvider {
    static var previews: some View {
        chatBox()
    }
}

