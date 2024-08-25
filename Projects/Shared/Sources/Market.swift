//
//  Market.swift
//  Shared
//
//  Created by 제이콥 on 6/13/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation

public struct Market: Hashable, Equatable{
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    public let code: String
    public let name: String
}

public struct MarketHelper {
    public init(){}
    public let markets: [Market] = [
        Market(code: "G20405", name: "편의점"),
        Market(code: "R10306", name: "종합 스포츠 센터"),
        Market(code: "I21201", name: "카페"),
        Market(code: "R10308", name: "수영장"),
        Market(code: "M11101", name: "동물병원"),
        Market(code: "Q102", name: "의원"),
        Market(code: "R10202", name: "독서실/스터디카페"),
        Market(code: "R10307", name: "헬스장"),
        Market(code: "S20901", name: "세탁소"),
        Market(code: "I203", name: "일식음식점"),
        Market(code: "R10406", name: "PC방"),
        Market(code: "R10407", name: "노래방"),
        Market(code: "S20701", name: "미용실"),
        Market(code: "S20902", name: "셀프빨래방"),
        Market(code: "P10501", name: "입시/교과학원"),
        Market(code: "G20404", name: "슈퍼마켓"),
        Market(code: "I201", name: "한식음식점"),
        Market(code: "Q10101", name: "종합병원"),
        Market(code: "I202", name: "중식음식점"),
        Market(code: "I211", name: "술집"),
        Market(code: "G21401", name: "주유소"),
        Market(code: "G21501", name: "약국"),
        Market(code: "I204", name: "양식음식점")

    ]
    
    public func isMiddleGroup(market: Market) -> Bool {
        return market.code.count < 6
    }
}
