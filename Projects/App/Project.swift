//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 제이콥 on 5/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

var extendedInfo: [String: Plist.Value] = [
    "ITSAppUsesNonExemptEncryption": false,
    "UILaunchScreen": [],
    "UISupportedInterfaceOrientations":
        [
            "UIInterfaceOrientationPortrait", // 인터페이스 방향을 세로만 지원.
        ],
    "UIUserInterfaceStyle": "Light"
]

let project = Project(name: "App",
                      organizationName: "projectG",
                      packages: [
                      ],
                      settings: Settings.settings(configurations: Project.makeConfiguration()),
                      targets: [Target(name: "App",
                                       platform: .iOS,
                                       product: .app,
                                       bundleId: Project.bundleId,
                                       deploymentTarget: .iOS(targetVersion: Project.iOSTargetVersion, devices: .iphone),
                                       infoPlist: .extendingDefault(with: extendedInfo),
                                       sources: ["Sources/**"],
                                       resources: ["Resources/**"],
                                       dependencies: [
                                        .project(target: "Feature", path: "../Feature")
                                       ]
                                      )
                      ])



