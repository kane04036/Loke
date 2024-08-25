//
//  NavigationBar.swift
//  Shared
//
//  Created by 제이콥 on 5/29/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI

public struct NavigationBar: View {
    
    // MARK: - Object lifecycle
    
    public init(leadingItem: any View, centerItem: any View, trailingItem: any View) {
        self.leadingItem = leadingItem
        self.centerItem = centerItem
        self.trailingItem = trailingItem
    }
    
    public init(leadingItem: any View) {
        self.leadingItem = leadingItem
    }
    
    public init(centerItem: any View) {
        self.centerItem = centerItem
    }
    
    public init(trailingItem: any View) {
        self.trailingItem = trailingItem
    }
    
    public init(leadingItem: any View, centerItem: any View) {
        self.leadingItem = leadingItem
        self.centerItem = centerItem
    }
    
    public init(centerItem: any View, trailingItem: any View) {
        self.centerItem = centerItem
        self.trailingItem = trailingItem
    }
    
    public init(leadingItem: any View, trailingItem: any View) {
        self.leadingItem = leadingItem
        self.trailingItem = trailingItem
    }
    
    // MARK: - Propoerties
    
    var leadingItem: any View = AnyView(Color.clear)
    var centerItem: any View = AnyView(Color.clear)
    var trailingItem: any View = AnyView(Color.clear)
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            AnyView(leadingItem)
                .frame(width: UIScreen.main.bounds.width * 0.15, alignment: .leading)
            
            AnyView(centerItem)
                .frame(maxWidth: .infinity, alignment: .center)
            
            AnyView(trailingItem)
                .frame(width: UIScreen.main.bounds.width * 0.15, alignment: .trailing)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 65)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

