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
    init(){
        FirebaseApp.configure()
    }
    
    @StateObject var geometryInfo: GeometryInfo = .init()
    @StateObject var appCoordinator: AppCoordinator = .init()
    @StateObject var mapData: MapData = .init()
    @StateObject var regionInformation: RegionInformation = .init()
    @StateObject var keyboardHandler: KeyboardHandler = .init()
    @StateObject var signUpViewModel: SignUpViewModel = .init()
    var body: some Scene {
        WindowGroup {
            GeometryReader(content: { geometry in
                HomeView()
                    .environmentObject(geometryInfo)
                    .environmentObject(appCoordinator)
                    .environmentObject(mapData)
                    .environmentObject(regionInformation)
                    .environmentObject(keyboardHandler)
                    .environmentObject(signUpViewModel)
                    .onAppear(perform: {
                        geometryInfo.initGeometry(geometryProxy: geometry)
                    })
                
            })
        }
    }
}
