//
//  LokeApp.swift
//  App
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Feature
import SwiftUI
import FirebaseCore
import Shared

@main
struct LokeApp: App {
    @StateObject var geometryInfo: GeometryInfo = .init()
    @StateObject var appCoordinator: AppCoordinator = .init()
    @StateObject var mapData: MapData = .init()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            GeometryReader(content: { geometry in
                HomeView()
                    .environmentObject(geometryInfo)
                    .environmentObject(appCoordinator)
                    .environmentObject(mapData)
                    .onAppear(perform: {
                        geometryInfo.initGeometry(geometryProxy: geometry)
                    })
                
            })
        }
    }
}
