//
//  profile.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI

struct profile: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var newname = ""
    @State var friendUID = ""
    @State private var showAlert = false
    @State private var backToLogIn = false
    @State private var moveToChatBox = false
    @State private var targetUID = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.Login{
                    let userName = viewModel.getUserName()
                    let userEmail = viewModel.getUserEmail()
                    VStack{
                        Text("Ｗelcome").font(.largeTitle)
                        Text("Your user name: \(userName)")
                        Text("Your email address: \(userEmail)")
                        
                        VStack{
                            Text("EDIT USER NAME:")
                            TextField("newname", text: $newname, prompt: Text("newname"))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .padding()
                            Button{
                                viewModel.changeName(username: newname)
                                showAlert = true
                            }label: {
                                Text("確認修改").foregroundColor(Color.black)
                                    .background(Color.white)
                            }.alert("User Name Changed", isPresented: $showAlert, actions: {
                                Button("OK") {
                                    showAlert = false
                                }
                        })
                        }.background(Color.blue)
                           
                        
                        Spacer()
                        
                        VStack{
                            Text("ADD Friend!")
                            TextField("friendUID", text: $friendUID, prompt: Text("friendUID"))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .padding()
                            Button{
                                viewModel.addFriendWuthUid(friendUID: friendUID)
                                showAlert = true
                            }label: {
                                Text("ADD").foregroundColor(Color.black)
                                    .background(Color.white)
                            }.alert("ADD Success", isPresented: $showAlert, actions: {
                                Button("OK") {
                                    showAlert = false
                                }
                        })
                        }.background(Color.blue)
                        
                        Spacer()
                        
                        VStack{
                            Text("Start to chat!")
                            TextField("UID", text: $targetUID, prompt: Text("UID"))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .padding()
                            Button{
                                if(targetUID != ""){
                                    viewModel.setTargetUserWithUid(UID: targetUID)
                                    viewModel.getMessages()
                                    moveToChatBox = true
                                }
                            }label: {
                                Text("CHAT!!").foregroundColor(Color.black)
                                    .background(Color.blue)
                            }.alert("ADD Success", isPresented: $showAlert, actions: {
                                Button("OK") {
                                    showAlert = false
                                }
                            })
                        }
                        
                        Spacer()
                        
                        Button{
                            viewModel.logout()
                            self.presentationMode.wrappedValue.dismiss()
                        } label:{
                            Text("登出")
                        }
                    }
                }
                else{
                    logIn()
                }
            }.navigate(to: chatBox(), when: $moveToChatBox)
            .onAppear{
                viewModel.Login = viewModel.isLogin
            }
        }
    }
}

struct profile_Previews: PreviewProvider {
    static var previews: some View {
        profile()
    }
}
