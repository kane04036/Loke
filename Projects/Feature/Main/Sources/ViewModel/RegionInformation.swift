//
//  RegionInformation.swift
//  Feature
//
//  Created by 제이콥 on 5/22/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Shared
import SwiftUI

public class RegionInformation: ObservableObject {
    public init(){}
    @Published var aptRent: AptRentService = AptRentService()
}
