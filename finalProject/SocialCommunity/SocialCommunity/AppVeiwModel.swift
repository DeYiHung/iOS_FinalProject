//
//  AppVeiwModel.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import Foundation
import Firebase


class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published private(set) var friends: [friend] = []
    @Published var Login = false
    @Published var messages: [message] = []
    @Published var lastMessageId: String = ""
    @Published var targetUser: user = user(id: "LjUVVDu23FX4hhoIGAP5StlbNez2", biography: "I'm admin", userName: "admin")
    //default user be admin
    
    
    
    var isLogin: Bool {
        return auth.currentUser != nil
    }
    
    func register(username:String, email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                print(error!)
                return
            }
            //success
            print("register success")
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { error in
               guard error == nil else {
                   print("register fail")
                   return
               }
            })
            
            let newUser = user(id: self?.getUserUID() , biography: "", userName: username)
            do{
                try self?.db.collection("users").document(self?.getUserUID() ?? "failed").setData(from: newUser)
            }catch {
                print(error)
            }
            
            DispatchQueue.main.async{
                self?.Login = true
            }
        }
    }
    
    
    func changeName(username:String){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges(completion: { error in
           guard error == nil else {
               print("asdfasfsafsafdf")
               return
           }
        })
    }
    
    func login(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                return
            }
            //success
            DispatchQueue.main.async{
                self?.Login = true
            }
        }
    }
    
    func logout(){
        try? auth.signOut()
        self.Login = false
    }
    
    func getUserName() -> String{
        if let user = Auth.auth().currentUser {
            return user.displayName ?? ""
        }
        else{
            return ""
        }
    }
    
    func getUserEmail() -> String{
        if let user = Auth.auth().currentUser {
            return user.email ?? ""
        }
        else {
            return ""
        }
    }
    
    func getUserUID() -> String{
        if let user = Auth.auth().currentUser {
            return user.uid
        }
        else {
            return ""
        }
    }
    
    func addFriendWuthUid(friendUID: String){
        let newFriend = friend(id: friendUID, addDate: Date() , tag: "normal")
        do{
            try self.db.collection("users").document(self.getUserUID()).collection("friends").document(friendUID).setData(from: newFriend)
            try self.db.collection("users").document(friendUID).collection("friends").document(self.getUserUID()).setData(from: newFriend)
            getFriends()
        }catch {
            print(error)
        }
    }
    
    func getFriends(){//update friends to current state
        db.collection("users").document(self.getUserUID()).collection("friends").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            self.friends = snapshot.documents.compactMap { snapshot in
                         try? snapshot.data(as: friend.self)
            }
        }
    }
    

    func getMessages() {
        db.collection("users").document(self.getUserUID()).collection("friends").document(self.targetUser.id ?? "").collection("messages").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> message? in
                do {
                    return try document.data(as: message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }

            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
        self.printmessages()
    }
    
    func sendMessage(text: String) {
        do {
            let messageSend = message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("users").document(self.getUserUID()).collection("friends").document(self.targetUser.id ?? "").collection("messages").document().setData(from: messageSend)
            let messageRecieved = message(id: "\(UUID())", text: text, received: true, timestamp: Date())
            try db.collection("users").document(self.targetUser.id ?? "").collection("friends").document(self.getUserUID()).collection("messages").document().setData(from: messageRecieved)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
    
    func setTargetUserWithUid(UID: String){
        db.collection("users").document(UID).getDocument{
            document,error in
            guard let document = document,document.exists,let targetUser = try? document.data(as: user.self)else {return}
            self.targetUser = targetUser
            print("change success")
        }
    }
    
    func printmessages(){
        for index in 0..<messages.count{
            print(messages[index])
        }
    }
    
}
