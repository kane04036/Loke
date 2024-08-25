//
//  SignUpManageView.swift
//  Feature
//
//  Created by 제이콥 on 5/30/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared

struct SignUpCenterView: View {
    // MARK: - Propoerties
    @EnvironmentObject var geometryInfo: GeometryInfo
    @EnvironmentObject var keyboardHandler: KeyboardHandler
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    let disabledButtonColor: Color = Color(red: 0.58, green: 0.8, blue: 1.0)
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                NavigationBar(leadingItem: BackButton)
                
                switch signUpViewModel.step {
                case 0: EmailInputView()
                case 1: PasswordInputView()
                case 2: PropertySelectView()
                case 3: MarketSelectView()
                case 4: ProfileSetView()
                default: EmptyView()
                }
                
                Spacer()
                
                NextButton
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var NextButton: some View {
        Button {
            if signUpViewModel.step == 4 {
                Task {
                    guard let uid = await signUpViewModel.createUser() else {return}
                    guard await signUpViewModel.userDataUpload(uid: uid) else {return}
                    appCoordinator.goRootView()
                }
                return
            }
            signUpViewModel.step += 1
        } label: {
            Text(signUpViewModel.getNextButtonTitle())
                .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(signUpViewModel.isButtonEnabled() ? ColorSet.main : disabledButtonColor)
        }
        .disabled(!signUpViewModel.isButtonEnabled())

    }
    
    var BackButton: some View {
        Button {
            appCoordinator.pop()
        } label: {
            SharedAsset.back.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
        }
        
    }
    
    // MARK: - Methods
    private func finishSignUpProcess() {
        
    }
}

struct TitleOfSignUpView: View {
    init(title: String) {
        self.title = title
    }
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 24))
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .lineSpacing(4)
    }
}

struct TitleOfFieldInSignUP: View {
    // MARK: - Object lifecycle
    init(title: String) {
        self.title = title
    }
    
    // MARK: - Propoerties
    let title: String
    
    // MARK: - View
    var body: some View {
        Text(title)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 14))
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 35)
    }
}

struct FeedbackTextInSignUP: View {
    init(title: String) {
        self.title = title
    }
    let title: String
    
    var body: some View {
        Text(title)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
            .foregroundStyle(Color.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)

    }
}
