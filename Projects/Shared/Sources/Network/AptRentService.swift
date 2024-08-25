//
//  RealEstateService.swift
//  Shared
//
//  Created by 제이콥 on 5/22/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Alamofire

public class AptRentService: NSObject, XMLParserDelegate, ObservableObject{
    public override init(){}
    @Published public var aptRentDatas: [AptRent] = []
    var temp: AptRent = .init()
    var tag: AptRentTagType = .none
    
    public func requestAptRent(code: String) {
        if code.isEmpty {return}
        self.aptRentDatas.removeAll()
        let url = NetworkURL.aptRent
        let dates = ["202404"]
        for date in dates {
            let parameters: Parameters = [
                "LAWD_CD": code,
                "DEAL_YMD": date,
                "serviceKey": "AV6q1MFauk1YrzkhSNrp+UeZ30uCKXoaSvPdQm/ba9RZqX4xFM672ZkIjQo7GfhMI9Ur1OLDh6D3MicNyIgTyQ=="
            ]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .validate(statusCode: 200 ..< 300)
                .response { response in
                    switch response.result {
                    case .success(let t):
                        guard let data = t else {return}
                        let parser = XMLParser(data: data)
                        parser.delegate = self
                        parser.parse()
                    case .failure(let error):
                        print(error)
                    }
                }
        }
       
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            temp = .init()
            tag = .none
        } else if elementName == "건축년도" {
            tag = .buildYear
        } else if elementName == "계약기간" {
            tag = .termOfContract
        } else if elementName == "년" {
            tag = .dealYear
        } else if elementName == "월" {
            tag = .dealYear
        } else if elementName == "동" {
            tag = .dong
        } else if elementName == "지번" {
            tag = .jibun
        } else if elementName == "보증금액" {
            tag = .deposit
        } else if elementName == "월세금액" {
            tag = .monthlyRent
        } else if elementName == "아파트" {
            tag = .apartmentName
        } else if elementName == "전용면적" {
            tag = .areaForExclusiveUse
        } else if elementName == "층" {
            tag = .floor
        } else if elementName == "일" {
            tag = .dealDay
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch tag {
        case .buildYear:
            temp.buildYear = Int(string) ?? 0
        case .termOfContract:
            temp.termOfContract = string
        case .dealYear:
            temp.dealYear = Int(string) ?? 0
        case .dong:
            temp.dong = string
        case .jibun:
            temp.jibun = string
        case .deposit:
            temp.deposit = Int(string) ?? 0
        case .apartmentName:
            temp.apartmentName = string
        case .dealMonth:
            temp.dealMonth = Int(string) ?? 0
        case .monthlyRent:
            temp.monthlyRent = Int(string) ?? 0
        case .areaForExclusiveUse:
            temp.areaForExclusiveUse = Double(string) ?? 0
        case .floor:
            temp.floor = Int(string) ?? 0
        case .dealDay:
            temp.dealMonth = Int(string) ?? 0
        case .none:
            break
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {    let calendar = Calendar.current
            if temp.monthlyRent == 0 {
                return
            }
            var components = DateComponents()
            components.year = temp.dealYear
            components.month = temp.dealMonth
            components.day = temp.dealDay
            temp.dealDate = calendar.date(from: components) ?? Date()
            
            self.aptRentDatas.append(temp)
            print("date: \(temp.dealDate), deposit: \(temp.monthlyRent)")
            aptRentDatas.sort(by: {$0.dealDate > $1.dealDate})
        }
    }
}


public enum NetworkResult<T> {
    case success(T)
    case failure(T)
}

enum AptRentTagType {
    case buildYear
    case termOfContract
    case dealYear
    case dong
    case jibun
    case deposit
    case apartmentName
    case dealMonth
    case monthlyRent
    case areaForExclusiveUse
    case floor
    case dealDay
    case none
}

public struct AptRent: Hashable, Identifiable {
    public var id: String {
        return "\(buildYear)-\(dealYear)-\(dealMonth)-\(dong)-\(jibun)"
    }
    
    public var buildYear: Int
    public var termOfContract: String
    public var dong: String
    public var deposit: Int
    public var apartmentName: String
    public var dealYear: Int
    public var dealMonth: Int
    public var dealDay: Int
    public var monthlyRent: Int
    public var areaForExclusiveUse: Double
    public var jibun: String
    public var floor: Int
    public var dealDate: Date
    
    public init() {
        self.buildYear = 0
        self.termOfContract = ""
        self.dealYear = 0
        self.dealDay = 0
        self.dong = ""
        self.deposit = 0
        self.apartmentName = ""
        self.dealMonth = 0
        self.monthlyRent = 0
        self.areaForExclusiveUse = 0
        self.jibun = ""
        self.floor = 0
        self.dealDate = Date()
    }
}
