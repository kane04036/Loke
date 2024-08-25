//
//  AuthSecureField.swift
//  Shared
//
//  Created by 제이콥 on 5/29/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI

public struct TextField_16: View {
    public init(text: Binding<String>, placeHolder: String) {
        self._text = text
        self.placeHolder = placeHolder
    }
    // MARK: - Propoerties
    
    @Binding var text: String
    let placeHolder: String
    
    // MARK: - View
    
    public var body: some View {
        TextField("text", text: $text, prompt: getPrompt(placeHolder: self.placeHolder))
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
    
    // MARK: - Methods
    
    func getPrompt(placeHolder: String) -> Text {
        Text(verbatim: placeHolder)
            .font(SharedFontFamily.Pretendard.light.swiftUIFont(size: 20))
            .foregroundColor(ColorSet.gray2)
    }
}


public struct UnderlineTextField_20: View {
    // MARK: - Object lifecycle
    public init(text: Binding<String>, placeHolder: String, isValid: Bool) {
        self._text = text
        self.placeHolder = placeHolder
        self.isValid = isValid
    }
    
    // MARK: - Propoerties
    @Binding var text: String
    let placeHolder: String
    var isValid: Bool
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: 0) {
            TextField("text", text: $text, prompt: getPrompt(placeHolder: placeHolder))
                .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 20))
                .foregroundStyle(Color.black)
                .padding(.top, 10)
                .textInputAutocapitalization(.never)
            
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .background(isValid ? ColorSet.main : Color.red)
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Methods
    func getPrompt(placeHolder: String) -> Text {
        Text(placeHolder)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 20))
            .foregroundColor(ColorSet.gray2)
    }
}

public struct UnderlineSecureField_20: View {
    // MARK: - Object lifecycle
    public init(text: Binding<String>, placeHolder: String, isValid: Bool) {
        self._text = text
        self.placeHolder = placeHolder
        self.isValid = isValid
    }
    
    // MARK: - Propoerties
    @Binding var text: String
    let placeHolder: String
    var isValid: Bool
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: 0) {
            SecureField("secure", text: $text, prompt: getPrompt(placeHolder: placeHolder))
                .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 20))
                .foregroundStyle(Color.black)
                .padding(.top, 10)
                .textInputAutocapitalization(.never)
            
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .background(isValid ? ColorSet.main : Color.red)
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Methods
    func getPrompt(placeHolder: String) -> Text {
        Text(placeHolder)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 20))
            .foregroundColor(ColorSet.gray2)
    }
}



public struct SecureField_16: View {
    public init(text: Binding<String>, placeHolder: String) {
        self._text = text
        self.placeHolder = placeHolder
    }
    
    // MARK: - Propoerties
    
    @Binding var text: String
    let placeHolder: String
    
    // MARK: - View
    
    public var body: some View {
        SecureField("secure", text: $text, prompt: getPrompt(placeHolder: self.placeHolder))
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
    
    // MARK: - Methods
    
    func getPrompt(placeHolder: String) -> Text {
        Text(placeHolder)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 16))
            .foregroundColor(ColorSet.gray2)
    }
}
