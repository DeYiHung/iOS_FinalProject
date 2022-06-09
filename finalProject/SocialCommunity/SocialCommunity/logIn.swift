//
//  logIn.swift
//  SocialCommunity
//
//  Created by kao on 2022/6/4.
//

import SwiftUI

struct logIn: View {
    @State var password = ""
    @State var emailAddress = ""
    @State private var showAlert = false
    @State private var moveToProfile = false
    @State private var moveToRegister = false
    @EnvironmentObject var viewModel: AppViewModel
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
    
        VStack(spacing: 49.80) {
            Spacer()
            
            Text("登入")
            .fontWeight(.bold)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .frame(width: 295, height: 43, alignment: .top)
            .lineSpacing(30)
            
            VStack{
                TextField("emailAddress", text: $emailAddress, prompt: Text("emailAddress"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
            }
            .frame(width: 328)
            

            VStack{
                SecureField(password, text: $password, prompt: Text("password"))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
            }
            .frame(width: 328)

            
            ZStack {
                ZStack {
                    Button{
                        if(password != "" && emailAddress != ""){
                            viewModel.login(email: emailAddress, password: password)
                            moveToProfile = true
                        }
                        else{
                            showAlert = true
                        }
                    }label: {
                        Text("登入")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(width: 108, height: 15, alignment: .top)
                        .lineSpacing(16)
                        .offset(x: 0, y: -2.50)
                    }.alert("Please enter your account", isPresented: $showAlert, actions: {Button("OK") {} })
                }
                .frame(width: 140, height: 48)
                .frame(width: 140, height: 48)
                .background(Color("perple"))
                .shadow(radius: 5, y: 4)
                .cornerRadius(16)

            }
            .frame(width: 140, height: 48)
            

            ZStack {
                ZStack {
                    Button{
                        moveToRegister = true
                    }label: {
                        Text("建立帳號")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(width: 108, height: 15, alignment: .top)
                        .lineSpacing(16)
                        .offset(x: 0, y: -2.50)
                    }
                }
                .frame(width: 140, height: 48)
                .frame(width: 140, height: 48)
                .background(Color.blue)
                .shadow(radius: 5, y: 4)
                .cornerRadius(12)

            }
            .frame(width: 140, height: 48)
        }
        .padding(.bottom, 177)
        .frame(width: 375, height: 812)
        .background(Color.white)
        .navigate(to: profile(), when: $moveToProfile)
        .navigate(to: register(), when: $moveToRegister)
    }
}
        

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct logIn_Previews: PreviewProvider {
    static var previews: some View {
        logIn()
    }
}
