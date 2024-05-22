//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 제이콥 on 5/2/24.
//

import ProjectDescription

let dependencie = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .exact("10.15.0")),
        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.7.0"))
//        .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .upToNextMajor(from: "7.0.0"))
    ]),
    platforms: [.iOS]
)
