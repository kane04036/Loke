//
//  RealEstateService.swift
//  Shared
//
//  Created by 제이콥 on 5/22/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Alamofire

class RealEstateService {
    static let shared = RealEstateService()
    
    public func searchAptRent(code: String, completion: ((NetworkResult<Any>) -> Void)) {
        
    }
}


enum NetworkResult<T> {
    case success(T)
    case failure(T)
}
