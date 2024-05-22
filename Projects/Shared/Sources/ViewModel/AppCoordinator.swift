//
//  AppCoordinator.swift
//  Shared
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation

public class AppCoordinator: ObservableObject {
    @Published public var stack: [Page] = []
    public init(){}
    
    public func pop() {
        self.stack.removeLast()
    }
    
    public func push(destination: Page) {
        self.stack.append(destination)
    }
    
    
}

public enum Page {
    case home
    case mypage
    case login
}
