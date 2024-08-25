//
//  KeyboardHandler.swift
//  Shared
//
//  Created by 제이콥 on 5/30/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
public class KeyboardHandler: ObservableObject {
    // MARK: - Object lifecycle
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Propoerties
    
    @Published public var keyboardHeight: CGFloat = 0
    
    
    // MARK: - Methods
    
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo: [AnyHashable: Any] = notification.userInfo else {return}
        guard let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.keyboardHeight = keyboardRectangle.height
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        self.keyboardHeight = 0
    }
}
