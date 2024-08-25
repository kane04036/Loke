//
//  UserDataForSignUp.swift
//  Feature
//
//  Created by 제이콥 on 5/30/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Shared

enum StepOfSingUp {
    case email
    case password
    case typeOfRealEstate
    case typeOfDeal
    case market
    case profile
}

enum ValidationState {
    case none
    case valid
    case formatError
    case duplicationError
    case incorrectError
}
public class SignUpViewModel: ObservableObject {
    public init(){}
    @Published var step: Int = 0

    @Published var email: String = ""
    @Published var isValidEmail: Bool = false

    @Published var password: String = ""
    @Published var isValidPassword: Bool = false
    
    @Published var selectedPropertyTypes: [PropertyType] = []
    @Published var selectedDealTypes: [DealType] = []
    
    @Published var saleRange: ClosedRange<Int> = 12000...30000
    @Published var contractRentRange: ClosedRange<Int> = 500...3000
    @Published var monthlyRentRange: ClosedRange<Int> = 50...100
    
    @Published var selectedMarkets: [Market] = []
    
    @Published var nickname: String = ""
    
    public func isButtonEnabled() -> Bool {
        switch step {
        case 0: return isValidEmail
        case 1: return isValidPassword
        case 2: return !selectedPropertyTypes.isEmpty && !selectedDealTypes.isEmpty
        case 3: return !selectedMarkets.isEmpty
        case 4: return !nickname.isEmpty
        default: return false
        }
    }
    
    public func getNextButtonTitle() -> String {
        switch step {
        case 4: return "회원가입"
        default: return "다음"
        }
    }
    
    public func createUser() async -> String? {
        let auth = FirebaseManager.shared.auth
        guard let result = try? await auth.createUser(withEmail: self.email, password: self.password) else {return nil}
        return result.user.uid
    }
    
    public func userDataUpload(uid: String) async -> Bool {
        let db = FirebaseManager.shared.db
        let query = db.collection("User").document(uid)
        let data: [String: Any] = [
            "email": email,
            "propertyType": convertPropertyTypeToString(),
            "dealType": convertDealTypeToString(),
            "saleRange": [
                "lowerBound": saleRange.lowerBound,
                "upperBound": saleRange.upperBound
            ],
            "contractRentRange": [
                "lowerBound": contractRentRange.lowerBound,
                "upperBound": contractRentRange.upperBound
            ],
            "monthlyRentRange": [
                "lowerBound": monthlyRentRange.lowerBound,
                "upperBound": monthlyRentRange.upperBound
            ],
            "market": selectedMarkets.map({$0.code}),
            "nickname": nickname
        ]
        guard let result = try? await query.setData(data) else {return false}
        return true
    }
    
    private func convertPropertyTypeToString() -> [String] {
        var returnValue: [String] = []
        for value in selectedPropertyTypes {
            switch value {
            case .apartment:
                returnValue.append("아파트")
            case .villa:
                returnValue.append("빌라")
            case .house:
                returnValue.append("주택")
            }
        }
        return returnValue
    }
    
    private func convertDealTypeToString() -> [String] {
        var returnValue: [String] = []
        for value in selectedDealTypes {
            switch value {
            case .sale:
                returnValue.append("매매")
            case .contractRent:
                returnValue.append("전세")
            case .monthlyRent:
                returnValue.append("월세")
            }
        }
        return returnValue
    }
    
}
