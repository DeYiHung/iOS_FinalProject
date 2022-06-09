//
//  message.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import Foundation

struct message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool //收件者為true寄件者為flase
    var timestamp: Date
}

