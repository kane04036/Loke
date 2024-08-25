//
//  BottomSheetView.swift
//  Feature
//
//  Created by 제이콥 on 5/22/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared

struct BottomSheetView: View {
    @EnvironmentObject var regionInformation: RegionInformation
    @EnvironmentObject var mapData: MapData
    @EnvironmentObject var appCoordinator: AppCoordinator
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            VStack(spacing: 0) {
                Text(mapData.location)
                    .onTapGesture {
                        appCoordinator.push(destination: .detail)
                    }
                ForEach(regionInformation.aptRent.aptRentDatas, id: \.self) { rent in
                    Text(rent.apartmentName)
                }
            }
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 0), style: .circular))
        
//        ZStack(alignment: .top, content: {
//            ScrollView {
//                VStack(spacing: nil, content: {
//                    ForEach(regionInformation.aptRent.aptRentDatas, id: \.self) { aptRent in
//                        Text("아파트 이름: \(aptRent.apartmentName)")
//                        Text("보증금: \(aptRent.deposit)")
//                        Text("월세: \(aptRent.monthlyRent)")
//                        Text("\n")
//                    }
//                })
//            }
//    
//        })
    }
}

#Preview {
    BottomSheetView()
}
