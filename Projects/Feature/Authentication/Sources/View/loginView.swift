//
//  loginView.swift
//  Feature
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared
import FirebaseAuth
import FirebaseCore


public struct loginView: View {
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var geometryInfo: GeometryInfo
    @StateObject var signInWithAppleManager: SignInWithAppleManager = SignInWithAppleManager()
    
    @State var email: String = ""
    @State var password: String = ""
    public init(){}
    
    // MARK: - View
    
    public var body: some View {
        ZStack(alignment: .top, content: {
            VStack(spacing: 0, content: {
                
                NavigationBar(leadingItem: BackButton)
                    .padding(.horizontal, 15)
                
                SharedAsset.logo.swiftUIImage
                    .padding(.bottom, 60)
                    .padding(.top, 40)
                
                TextField_16(text: $email, placeHolder: "이메일")
                
                SecureField_16(text: $password, placeHolder: "비밀번호")
                    .padding(.top, 8)
                
                FindPasswordButton
                
                LoginButton
                
                SocialLoginDivider
                
                AppleLoginButton
                
                Spacer()
                
                SignUpButton
            })
            
        })
        .navigationBarBackButtonHidden()
        
    }
    
    var SignUpButton: some View {
        Button {
            appCoordinator.push(destination: .signUp)
        } label: {
            HStack(alignment: .bottom, spacing: 3, content: {
                Text("계정이 없으신가요?")
                    .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
                    .foregroundStyle(ColorSet.darkgray1)
                
                Text("회원가입하기")
                    .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 13))
                    .foregroundStyle(ColorSet.main)
                    .underline()
            })
            .padding(.bottom, geometryInfo.height * 0.1)
        }
    }
    
    
    var SocialLoginDivider: some View {
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
    }
    
    var AppleLoginButton: some View {
        Button {
            signInWithAppleManager.performSignIn()
        } label: {
            SharedAsset.appleLogin.swiftUIImage
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top, 25)
        }
    }
    
    var LoginButton: some View {
        Button(action: {
            login()
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
    }
    
    var FindPasswordButton: some View {
        Text("비밀번호 찾기")
            .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 12))
            .foregroundStyle(ColorSet.darkgray1)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 35)
            .padding(.top, 5)
    }
    
    var BackButton: some View {
        Button(action: {
            appCoordinator.pop()
        }, label: {
            SharedAsset.back.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
        })
    }
    
    // MARK: - Methods
    
    private func login() {
        
    }
    
}
