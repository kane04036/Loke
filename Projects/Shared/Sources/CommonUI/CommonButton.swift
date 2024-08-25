//
//  CommonButton.swift
//  Shared
//
//  Created by 제이콥 on 6/12/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI

public struct RoundedToggleButton<T: Equatable & Hashable>: View {
    // MARK: - Object lifecycle
    public init(title: String, item: T, list: Binding<[T]>) {
        self.title = title
        self.item = item
        self._list = list
    }
    
    // MARK: - Propoerties
    let title: String
    let item: T
    @Binding var list: [T]
    
    let textGray: Color = Color(white: 0.53)
    let backgroundGray: Color = Color(white: 0.98)
    let borderGray: Color = Color(white: 0.84)
    let backgroundBlue: Color = Color(red: 0.93, green: 0.97, blue: 1.0)
    
    // MARK: - View
    public var body: some View {
        Button {
            toggleAction()
        } label: {
            Text(title)
                .font(contains() ? SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 16) : SharedFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                .foregroundStyle(contains() ? ColorSet.main : textGray)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(contains() ? backgroundBlue : backgroundGray)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                .overlay {
                    RoundedRectangle(cornerRadius: 30, style: .circular)
                        .strokeBorder(contains() ? ColorSet.main : borderGray, lineWidth: 1)
                }
        }

    }
    
    // MARK: - Methods
    private func contains() -> Bool {
        return list.contains(where: {$0 == item})
    }
    
    private func toggleAction() {
        if contains() {
            withAnimation {
                list.removeAll(where: {$0 == item})
            }
        } else {
            withAnimation {
                list.append(item)
            }
        }
    }
}

