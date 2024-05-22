//
//  GeometryInfo.swift
//  Shared
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import SwiftUI

public class GeometryInfo: ObservableObject {
    @Published public var width: CGFloat = 0
    @Published public var height: CGFloat = 0
    @Published public var topInset: CGFloat = 0
    @Published public var bottmInset: CGFloat = 0
    
    public init(){}
    public func initGeometry(geometryProxy: GeometryProxy) {
        self.width = geometryProxy.size.width
        self.height = geometryProxy.size.height
        self.topInset = geometryProxy.safeAreaInsets.top
        self.bottmInset = geometryProxy.safeAreaInsets.bottom
    }
    
}
