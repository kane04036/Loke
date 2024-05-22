//
//  MapData.swift
//  Feature
//
//  Created by 제이콥 on 5/16/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

public class MapData: ObservableObject {
    public init(){}
    @Published public var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published public var location: String = ""
    @Published public var span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0)
    @Published public var localCodeTable: [LocalCode] = []
    
    public func getLocationCode(location: String) -> String {
        if localCodeTable.isEmpty {loadLocalCode()}
        guard var code = self.localCodeTable.first(where: {$0.location == location})?.code else {print("no code"); return ""}
        code = String(code.prefix(5))
        return code
    }
    
    private func loadLocalCode() {
        guard let path = SharedResources.bundle.path(forResource: "localCode", ofType: "csv") else {print("path error"); return}
        let url = URL(filePath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let array = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                self.localCodeTable = array.compactMap({LocalCode(value: $0)})
            }
        } catch {
            print("csv file parsing error")
        }
    }
}

public struct LocalCode {
    public init(value: [String]) {
        self.code = value[0]
        self.location = value[1]
    }
    let code: String
    let location: String
}
