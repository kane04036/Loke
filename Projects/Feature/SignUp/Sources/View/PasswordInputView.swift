//
//  PasswordInputView.swift
//  Feature
//
//  Created by 제이콥 on 6/12/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared

struct PasswordInputView: View {
    enum PasswordField {
        case password
        case confirm
    }
    
    enum PasswordValidationStatus {
        case none
        case error
        case valid
    }

    
    // MARK: - Propoerties
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    @FocusState private var focusedField: PasswordField?
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State private var timer: Timer?
    
    @State var passwordValidationStatus: PasswordValidationStatus = .none
    @State var confirmValidationStatus: PasswordValidationStatus = .none
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0, content: {
            
            TitleOfSignUpView(title: "비밀번호를\n입력해주세요")
            
            TitleOfFieldInSignUP(title: "비밀번호")
            
            UnderlineSecureField_20(text: $password, placeHolder: "영문, 숫자, 특수기호로 조합된 8~20자", isValid: passwordValidationStatus == .none || passwordValidationStatus == .valid)
                .onChange(of: password, perform: { value in
                    passwordValidationStatus = .none
                    signUpViewModel.isValidPassword = false
                })
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .password
                }

            
            FeedbackTextInSignUP(title: getFeedbackMsgOfPassword())
                .padding(.top, 10)
            
            TitleOfFieldInSignUP(title: "비밀번호 확인")
            
            UnderlineSecureField_20(text: $confirmPassword, placeHolder: "다시 한 번 입력해주세요", isValid: confirmValidationStatus == .none || confirmValidationStatus == .valid)
                .onChange(of: password, perform: { value in
                    confirmValidationStatus = .none
                    signUpViewModel.isValidPassword = false
                })
                .focused($focusedField, equals: .confirm)
                .onSubmit {
                    focusedField = .confirm
                }

            
            FeedbackTextInSignUP(title: getFeedbackMsgOfConfirm())
                .padding(.top, 10)


        })
        .onAppear(perform: {
            setTimerToCheckValidation()
            focusedField = .password
        })
        .onDisappear(perform: {
            self.timer?.invalidate()
        })

    }
    
    // MARK: - Methods
    
    private func setTimerToCheckValidation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true, block: { _ in
            if password.isEmpty {
                passwordValidationStatus = .none
                confirmValidationStatus = .none
                return
            }
            
            guard isCorrectFormat() else {
                passwordValidationStatus = .error
                confirmValidationStatus = .none
                return
            }
            
            passwordValidationStatus = .valid
            
            if confirmPassword.isEmpty {
                return
            }
            
            guard isConfirmSameToPassword() else {
                confirmValidationStatus = .error
                return
            }
            
            passwordValidationStatus = .valid
            confirmValidationStatus = .valid
            signUpViewModel.isValidPassword = true
            signUpViewModel.password = self.password
        })
    }
    
    private func isCorrectFormat() -> Bool {
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self.password)
    }
    
    
    private func isConfirmSameToPassword() -> Bool {
        return self.password == self.confirmPassword
    }
    
    private func getFeedbackMsgOfConfirm() -> String {
        if confirmValidationStatus == .error {
            return "비밀번호가 다릅니다. 다시 한 번 확인해 주세요."
        }
        return ""
    }
    
    private func getFeedbackMsgOfPassword() -> String {
        if passwordValidationStatus == .error {
            return "영문, 숫자, 특수기호로 모두 조합된 8~20자"
        }
        return ""
    }

}
