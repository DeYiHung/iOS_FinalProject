//
//  messageBubble.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI

struct messageBubble: View {
    var message: message
    
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("Gray") : Color(.orange))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct messageBubble_Previews: PreviewProvider {
    static var previews: some View {
        messageBubble(message: message(id: "12345", text: "It's just a test message!", received: false, timestamp: Date()))
            .previewLayout(.sizeThatFits)
    }
}

