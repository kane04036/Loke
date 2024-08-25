//
//  SelectRealEstateView.swift
//  Feature
//
//  Created by 제이콥 on 6/12/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared
enum PropertyType {
    case apartment
    case villa
    case house
}

enum DealType {
    case sale
    case contractRent
    case monthlyRent
}

struct PropertySelectView: View {
    // MARK: - Propoerties
    @EnvironmentObject var signUpViewModel: SignUpViewModel

    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            TitleOfSignUpView(title: "선호하는 부동산 거래 유형과\n금액대를 선택해주세요")
            
            PropertyStackView
            
            if isPropertyChosen() {
                DealStackView
            }
            
            if contains(dealType: .sale) {
                TitleOfPropertyInSingUp(title: "매매")
                PriceInputView(priceRange: $signUpViewModel.saleRange)
            }
            
            if contains(dealType: .contractRent) {
                TitleOfPropertyInSingUp(title: "보증금(전세)")
                PriceInputView(priceRange: $signUpViewModel.contractRentRange)
            }
            
            if contains(dealType: .monthlyRent) {
                TitleOfPropertyInSingUp(title: "월세")
                PriceInputView(priceRange: $signUpViewModel.monthlyRentRange)
            }
        }
    }
    
    var PropertyStackView: some View {
        HStack(spacing: 10) {
            RoundedToggleButton(title: "아파트", item: PropertyType.apartment, list: $signUpViewModel.selectedPropertyTypes)
            RoundedToggleButton(title: "빌라", item: PropertyType.villa, list: $signUpViewModel.selectedPropertyTypes)
            RoundedToggleButton(title: "주택", item: PropertyType.house, list: $signUpViewModel.selectedPropertyTypes)
            DuplicationSelectionText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 40)

    }
    
    var DealStackView: some View {
        HStack(spacing: 10) {
            RoundedToggleButton(title: "매매", item: DealType.sale, list: $signUpViewModel.selectedDealTypes)
            RoundedToggleButton(title: "전세", item: DealType.contractRent, list: $signUpViewModel.selectedDealTypes)
            RoundedToggleButton(title: "월세", item: DealType.monthlyRent, list: $signUpViewModel.selectedDealTypes)
            DuplicationSelectionText
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)

    }
    var DuplicationSelectionText: some View {
        Text("중복선택 가능")
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
            .foregroundStyle(ColorSet.darkgray2)
    }
    
    
    // MARK: - Methods
    
    private func contains(propertyType: PropertyType) -> Bool {
        return self.signUpViewModel.selectedPropertyTypes.contains(where: {$0 == propertyType})
    }
    
    private func contains(dealType: DealType) -> Bool {
        return self.signUpViewModel.selectedDealTypes.contains(where: {$0 == dealType})
    }
    
    private func isPropertyChosen() -> Bool {
        return !signUpViewModel.selectedPropertyTypes.isEmpty
    }
}

struct TitleOfPropertyInSingUp: View {
    init(title: String) {
        self.title = title
    }
    let title: String
    
    // MARK: - View
    var body: some View {
        Text(title)
            .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 14))
            .foregroundStyle(ColorSet.darkgray1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 35)
            .padding(.top, 10)
    }
}

///부동산 금액 최소, 최대 입력 뷰
struct PriceInputView: View {
    // MARK: - Object lifecycle
    init(priceRange: Binding<ClosedRange<Int>>) {
        self._priceRange = priceRange
        self.lowerBound = priceRange.wrappedValue.lowerBound
        self.upperBound = priceRange.wrappedValue.upperBound
    }
    
    // MARK: - Propoerties
    @Binding var priceRange: ClosedRange<Int>
    
    @State var lowerBound: Int
    @State var upperBound: Int
    
    @State var lowText: String = ""
    @State var upText: String = ""
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            PriceInputField(price: $lowerBound)
        
            Text("~")
                .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
                .foregroundStyle(Color.black)
            
            PriceInputField(price: $upperBound)
                
        }
        .padding(.horizontal, 35)
        .padding(.top, 10)
    }
}

///부동산 금액 입력하고 한글로 바꿔서 보여주는 뷰
struct PriceInputField: View {
    init(price: Binding<Int>) {
        self._price = price
    }
    @Binding var price: Int
    @State var priceText = ""
    
    // MARK: - View
    var body: some View {
        HStack(spacing: 5) {
            
            VStack(spacing: 0) {
                InputField
                TranslatedText
            }
            .padding(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .stroke(ColorSet.gray2, lineWidth: 1)
            }
            
            Text("만원")
                .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
        }
        .onAppear {
            translatePriceToText()
        }
    }
    
    var InputField: some View {
        TextField("", value: $price, format: .number)
            .font(SharedFontFamily.Pretendard.medium.swiftUIFont(size: 16))
            .multilineTextAlignment(.trailing)
            .foregroundStyle(Color.black)
            .keyboardType(.numberPad)
            .onChange(of: price) { newValue in
                translatePriceToText()
            }
    }
    
    var TranslatedText: some View {
        Text(priceText)
            .font(SharedFontFamily.Pretendard.regular.swiftUIFont(size: 12))
            .foregroundStyle(ColorSet.gray2)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    // MARK: - Methods
    private func translatePriceToText() {
        let hundredMillion = price / 10000
        let tenThousand = price % 10000
        priceText = hundredMillion > 0 ? "\(hundredMillion)억 " : ""
        priceText += tenThousand > 0 ? "\(tenThousand)만원" : ""
        
        if priceText.isEmpty {
            priceText = "0원"
        }
    }
}
