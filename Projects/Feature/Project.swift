//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 제이콥 on 5/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "Feature",
                      organizationName: "projectG",
                      packages: [],
                      targets: [Target(name: "Feature",
                                       platform: .iOS,
                                       product: .framework,
                                       bundleId: Project.bundleId + ".feature",
                                       deploymentTarget: .iOS(targetVersion: Project.iOSTargetVersion, devices: .iphone),
                                       infoPlist: .default,
                                       sources: ["**/Sources/**"],
//                                       resources: ["Resources/**"],
                                       dependencies: [
                                        .project(target: "Shared", path: "../Shared"),
                                       ])
                      ])
