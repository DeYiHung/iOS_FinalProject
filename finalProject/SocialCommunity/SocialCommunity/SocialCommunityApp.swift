//
//  SocialCommunityApp.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI
import Firebase

@main
struct SocialCommunityApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView().environmentObject(viewModel)
        }
    }
}
