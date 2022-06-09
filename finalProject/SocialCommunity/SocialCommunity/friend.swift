//
//  friend.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/8.
//

import Foundation
import FirebaseFirestoreSwift

struct friend: Identifiable, Codable {
    @DocumentID var id: String?
    var addDate: Date
    var tag: String
}
