//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 제이콥 on 5/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

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
                                       infoPlist: Project.makeInfoPlist(), // 추후 plist 변경시 메서드 수정해서 사용
                                       sources: ["Sources/**"],
                                       resources: ["Resources/**"],
                                       dependencies: [
                                        .project(target: "Feature", path: "../Feature"),
                                        .project(target: "Shared", path: "../Shared")
                                       ]
                                      )
                      ])
