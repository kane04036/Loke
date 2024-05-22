//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 제이콥 on 5/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers


let project = Project(name: "Shared",
                      organizationName: "projectG",
                      packages: [],
                      targets: [Target(name: "Shared",
                                       platform: .iOS,
                                       product: .framework,
                                       bundleId: Project.bundleId + ".shared",
                                       deploymentTarget: .iOS(targetVersion: Project.iOSTargetVersion, devices: .iphone),
                                       infoPlist: .default,
                                       sources: ["Sources/**"],
                                       resources: ["Resources/**"],
                                       dependencies: [
                                        .external(name: "FirebaseAuth"),
                                        .external(name: "FirebaseFirestore"),
                                        .external(name: "FirebaseMessaging"),
                                        .external(name: "Alamofire")
                                       ],
                                       settings: Settings.settings(base: [
                                        "HEADER_SEARCH_PATHS": "$(inherited) $(SRCROOT)/../../Tuist/Dependencies/SwiftPackageManager/.build/checkouts/gtm-session-fetcher/Sources/Core/Public",
                                        "OTHER_LDFLAGS" : "-ObjC"

                                       ])
                                      )
                      ])




