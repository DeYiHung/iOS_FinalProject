//
//  register.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI

struct register: View {
    
    @State var name = ""
    @State var password = ""
    @State var emailAddress = ""
    @State private var showAlert = false
    @State private var moveToLogIn = false
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                Text("立即加入我們！")
                .fontWeight(.bold)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .frame(width: 295, height: 43, alignment: .top)
                .lineSpacing(30)
                
                Spacer()
                Spacer()
                
                VStack(spacing:10){
                    HStack{
                        Image(systemName: "person.fill")
                            .font(.system(size: 30.0))
                        Text("使用者名稱")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .frame(width: 328, alignment: .topLeading)
                        .lineSpacing(20)
                        
                    }
                    TextField("name", text: $name, prompt: Text("name"))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()

                    HStack{
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 30.0))
                        Text("電子郵件")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .frame(width: 328, alignment: .topLeading)
                        .lineSpacing(20)
                    }
                    TextField("emailAddress", text: $emailAddress, prompt: Text("emailAddress"))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .font(.system(size: 30.0))
                        Text("密碼")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .frame(width: 328, alignment: .topLeading)
                        .lineSpacing(20)
                    }
                    TextField("password", text: $password, prompt: Text("password"))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
                    Text("密碼長度需大於6碼")
                    .font(.caption)
                    .lineSpacing(18)
                    .frame(width: 328)
                }
                
                Spacer()
                
                ZStack{
                    Button{
                        showAlert = true
                        viewModel.register(username: name, email: emailAddress, password: password)
                    
                    }label:{
                        Text("建立帳號")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 108, height: 15, alignment: .top)
                            .lineSpacing(16)
                            .offset(x: 0, y: -2.50)
                    }.alert("Create Success", isPresented: $showAlert, actions: {
                        Button("OK") { }
                    })
                }
                .frame(width: 140, height: 48)
                .frame(width: 140, height: 48)
                .background(Color("perple"))
                .shadow(radius: 5, y: 4)
                .cornerRadius(16)
            
                
                ZStack{
                    Button{
                        moveToLogIn = true
                    }label:{
                        Text("回到登入")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .frame(width: 108, height: 15, alignment: .top)
                            .lineSpacing(16)
                            .offset(x: 0, y: -2.50)
                    }.alert("Create Success", isPresented: $showAlert, actions: {
                        Button("OK") { }
                    })
                }
                .frame(width: 140, height: 48)
                .frame(width: 140, height: 48)
                .background(Color.blue)
                .shadow(radius: 5, y: 4)
                .cornerRadius(16)
            }
            .navigate(to: logIn(), when: $moveToLogIn)
        }
    }
}

struct register_Previews: PreviewProvider {
    static var previews: some View {
        register()
    }
}
