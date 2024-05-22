//
//  loginView.swift
//  Feature
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared
//import GoogleSignIn
import FirebaseAuth
import FirebaseCore

public struct loginView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var signInWithAppleManager: SignInWithAppleManager = SignInWithAppleManager()
    
    @State var email: String = ""
    @State var password: String = ""
    public init(){}
    
    public var body: some View {
        ZStack(alignment: .top, content: {
            ScrollView {
                VStack(spacing: 0, content: {
                    
                    HStack(alignment: .center, spacing: 0, content: {
                        SharedAsset.back.swiftUIImage
                            .onTapGesture {
                                appCoordinator.pop()
                            }
                        Spacer()
                    })
                    .frame(height: 65)
                    .padding(.horizontal, 15)
                    
                    SharedAsset.logo.swiftUIImage
                        .padding(.bottom, 60)
                        .padding(.top, 40)
                    
                    AuthTextField(text: $email, placeHolder: "이메일")
                    
                    AuthSecureField(text: $password, placeHolder: "비밀번호")
                        .padding(.top, 8)
                    
                    Text("비밀번호 찾기")
                        .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
                        .foregroundStyle(ColorSet.darkgray1)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 35)
                        .padding(.top, 5)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("로그인하기")
                            .font(SharedFontFamily.Pretendard.bold.swiftUIFont(size: 18))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(ColorSet.main)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            .padding(.horizontal, 35)
                            .padding(.top, 20)
                    })
                    
                    HStack(spacing: 15, content: {
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(ColorSet.gray2)
                        
                        Text("간편 로그인")
                            .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 12))
                            .foregroundStyle(Color(white: 0.45))
                        
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(ColorSet.gray2)
                    })
                    .padding(.horizontal, 15)
                    .padding(.top, 40)
                    
                    HStack(spacing: 25, content: {
                        SharedAsset.appleLogin.swiftUIImage
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                signInWithAppleManager.performSignIn()
                            }
                        
                        SharedAsset.googleLogin.swiftUIImage
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                    })
                    .padding(.top, 25)
                    Spacer()
                    
                    HStack(alignment: .bottom, spacing: 3, content: {
                        Text("계정이 없으신가요?")
                            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
                            .foregroundStyle(ColorSet.darkgray1)
                        
                        Text("회원가입하기")
                            .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 13))
                            .foregroundStyle(ColorSet.main)
                            .underline()
                    })
                    .padding(.bottom, 40)
                })
                
            }
            
        })
        .navigationBarBackButtonHidden()
        
        
    }
    
//    func googleLogin(){
//        guard let id = FirebaseApp.app()?.options.clientID else { return }
//        let config = GIDConfiguration(clientID: id)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let window = windowScene.windows.first,
//              let presentingVC = window.rootViewController else {
//            print("No root view controller")
//            return
//        }
//        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
//            if let error = error{
//                print("google error: \(error)")
//            }else{
//                print("google login success")
//                guard let idToken = result?.user.idToken?.tokenString else {print("no idToken");return}
//                guard let accessToken = result?.user.accessToken.tokenString else {print("no accessToken");return}
//                
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                
//                Auth.auth().signIn(with: credential){(result, error) in
//                    if let error = error {
//                        print("create user error: \(error)")
//                    }else if let user = result?.user{
//                        print("success creating or login user ")
//                    }
//                }
//            }
//        }
//    }
    
    #Preview {
        loginView()
    }
    
    struct AuthTextField: View {
        @Binding var text: String
        let placeHolder: String
        init(text: Binding<String>, placeHolder: String) {
            self._text = text
            self.placeHolder = placeHolder
        }
        var body: some View {
            TextField("title", text: $text, prompt: getPrompt(placeHolder: self.placeHolder))
                .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 16))
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity)
                .padding(.leading, 10)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(ColorSet.gray2, lineWidth: 1)
                }
                .padding(.horizontal, 35)
        }
        
        func getPrompt(placeHolder: String) -> Text {
            Text(placeHolder)
                .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                .foregroundColor(ColorSet.gray2)
        }
    }
    
    struct AuthSecureField: View {
        @Binding var text: String
        let placeHolder: String
        init(text: Binding<String>, placeHolder: String) {
            self._text = text
            self.placeHolder = placeHolder
        }
        var body: some View {
            SecureField("title", text: $text, prompt: getPrompt(placeHolder: self.placeHolder))
                .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 16))
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity)
                .padding(.leading, 10)
                .padding(.vertical, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(ColorSet.gray2, lineWidth: 1)
                }
                .padding(.horizontal, 35)
        }
        
        func getPrompt(placeHolder: String) -> Text {
            Text(placeHolder)
                .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                .foregroundColor(ColorSet.gray2)
        }
    }
}
