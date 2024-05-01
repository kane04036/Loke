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
                                       resources: ["Resources/**"]
                                      )
                      ])




