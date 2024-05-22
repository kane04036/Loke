//
//  TopBarView.swift
//  Shared
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    var leadingImage: SharedImages?
    var trailingImage: SharedImages?
    var title: String = ""
    var leadingAction: (() -> Void)?
    var trainlingAction: (() -> Void)?
    

    var body: some View {
        HStack(spacing: 0, content: {
            Button(action: {}, label: {
                
            })
        })
    }
}

#Preview {
    TopBarView()
}
