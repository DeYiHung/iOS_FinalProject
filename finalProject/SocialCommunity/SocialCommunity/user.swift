//
//  user.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/8.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

struct user: Identifiable, Codable {
    @DocumentID var id: String?
    var biography: String
    var userName: String
}
