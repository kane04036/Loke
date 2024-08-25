//
//  InputEmailPWView.swift
//  Feature
//
//  Created by 제이콥 on 5/30/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared



struct EmailInputView: View {
    // MARK: - Object lifecycle
    init() {
        self.isFocused = true
    }
    
    public enum EmailValidationState {
        case none
        case valid
        case formatError
        case duplicationError
    }
    
    
    // MARK: - Propoerties
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var previousEmail: String = ""
    @State private var validationStatus: EmailValidationState = .none
    
    @FocusState private var isFocused: Bool
    @State var timer: Timer?
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {   
                TitleOfSignUpView(title: "이메일을\n입력해주세요")
                
                TitleOfFieldInSignUP(title: "이메일")
                
                UnderlineTextField_20(text: $signUpViewModel.email, placeHolder: "user@loke.com", isValid: validationStatus == .none || validationStatus == .valid)
                    .onChange(of: signUpViewModel.email, perform: { value in
                        setSignUpData(status: .none)
                        if !(timer?.isValid ?? false) {
                            setTimerFunctionedForCheckingEmailValidation()
                        }
                    })
                    .focused($isFocused)
                
                
                FeedbackTextInSignUP(title: getFeedbackMsg())
                    .padding(.top, 10)
                    .opacity(signUpViewModel.isValidEmail ? 0 : 1)
            }
        }
        .onAppear(perform: {
            setTimerFunctionedForCheckingEmailValidation()
            isFocused = true
        })
        .onDisappear(perform: {
            self.timer?.invalidate()
        })
        
        
    }
    
    
    // MARK: - Methods
    private func setTimerFunctionedForCheckingEmailValidation() {
        self.previousEmail = self.signUpViewModel.email
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            //            signUpViewModel.isLoading = true
            guard !self.signUpViewModel.email.isEmpty else {
                setSignUpData(status: .none)
                return
            }
            
            let isEndEditing = (previousEmail == self.signUpViewModel.email)
            guard isEndEditing else {
                previousEmail = self.signUpViewModel.email
                return
            }
            
            guard isCorrectFormat() else {
                setSignUpData(status: .formatError)
                return
            }
            
            Task {
                if await isValidEmail() {
                    setSignUpData(status: .valid)
                    self.timer?.invalidate()
                } else {
                    setSignUpData(status: .duplicationError)
                }
            }
            
        }
    }
    
    private func isCorrectFormat() -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self.signUpViewModel.email)
    }
    
    private func isValidEmail() async -> Bool {
        let db = FirebaseManager.shared.db
        let query = db.collection("User").whereField("email", isEqualTo: self.signUpViewModel.email)
        guard let documents = try? await query.getDocuments() else {return false}
        
        return documents.isEmpty
    }
    
    private func getFeedbackMsg() -> String {
        switch self.validationStatus {
        case .formatError:
            return "이메일 형식이 올바르지 않습니다."
        case .duplicationError:
            return "이미 사용 중인 이메일입니다."
        default: return ""
        }
    }
    
    ///유효성 결과 설정 및 로딩 상태, 회원가입 뷰모델 내부 이메일 값 수정
    private func setSignUpData(status: EmailValidationState) {
        self.validationStatus = status
        switch status {
        case .valid:
            signUpViewModel.isValidEmail = true
        default:
            signUpViewModel.isValidEmail = false
        }
        //        signUpViewModel.isLoading = false
    }
}
