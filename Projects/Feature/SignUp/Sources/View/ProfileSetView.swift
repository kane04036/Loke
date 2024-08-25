//
//  ProfileSetView.swift
//  Feature
//
//  Created by 제이콥 on 6/13/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared

struct ProfileSetView: View {
    // MARK: - Propoerties
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @FocusState var isFocus: Bool
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            TitleOfSignUpView(title: "프로필 정보를\n입력해주세요")
            
            //사진 추가 기능 넣기
            SharedAsset.defaultProfile.swiftUIImage
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.top, 84)
            
            UnderlineTextField_20(text: $signUpViewModel.nickname, placeHolder: "닉네임", isValid: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
                .padding(.top, 50)
                .focused($isFocus)
        }
        .onAppear {
            isFocus = true
        }
    }
}
