//
//  HomeView.swift
//  Feature
//
//  Created by 제이콥 on 5/2/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared
import MapKit

public struct HomeView: View {
    @EnvironmentObject var geometryInfo: GeometryInfo
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var mapData: MapData
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    public init(){}
    
    public var body: some View {
        NavigationStack(path: $appCoordinator.stack) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                VStack(spacing: 0, content: {
                    //상단바
                    HStack(alignment: .center, spacing: 10, content: {
                        Text(mapData.location)
                            .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                            .foregroundStyle(Color.black)
                        Spacer()
                        SharedAsset.search.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        SharedAsset.defaultProfile.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                appCoordinator.push(destination: .login)
                            }
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .padding(.top, geometryInfo.topInset)
                    
                    HomeMapView()
                        .ignoresSafeArea()
                    

                    
                    Spacer()
                })
                .ignoresSafeArea()

               
            })
            .navigationDestination(for: Page.self) { destination in
                switch destination {
                case .home: HomeView()
                case .login: loginView()
                case .mypage: loginView()
                }
            }
        }
  

    }
}

#Preview {
    HomeView()
}
