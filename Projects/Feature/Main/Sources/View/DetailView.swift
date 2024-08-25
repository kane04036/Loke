//
//  DetailView.swift
//  Feature
//
//  Created by 제이콥 on 6/13/24.
//  Copyright © 2024 hollys. All rights reserved.
//

import SwiftUI
import Shared
import Charts

enum TabBarPage {
    case property
    case traffic
    case market
    case review
}

struct DetailView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var mapData: MapData
    @EnvironmentObject var regionInformation: RegionInformation
    @State var selection: TabBarPage = .property
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar(leadingItem: BackButton, centerItem: AddressText, trailingItem: BookmarkButton)

            TabBar
            
            ScrollView {
                Chart(regionInformation.aptRent.aptRentDatas) { aptRent in
                    LineMark(x: .value("Date", aptRent.dealDate), y: .value("Sale Rent Price", aptRent.monthlyRent))
                }
            }

        }
        .navigationBarBackButtonHidden()
    }
    
    var TabBar: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TabBarText(type: .property, selection: $selection)
                TabBarText(type: .traffic, selection: $selection)
                TabBarText(type: .market, selection: $selection)
                TabBarText(type: .review, selection: $selection)
            }
            .padding(.top, 15)
        }
    }
    
    var BackButton: some View {
        Button {
            appCoordinator.pop()
        } label: {
            SharedAsset.back.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    var AddressText: some View {
        Text(mapData.location)
            .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
            .foregroundStyle(Color.black)
    }
    
    var BookmarkButton: some View {
        Button {
            //
        } label: {
            SharedAsset.bookmark.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)

        }

    }
}

#Preview {
    DetailView()
}

struct TabBarText: View {
    init(type: TabBarPage, selection: Binding<TabBarPage>) {
        self.type = type
        self._selection = selection
        switch type {
        case .property:
            self.title = "부동산"
        case .traffic:
            self.title = "교통"
        case .market:
            self.title = "상권"
        case .review:
            self.title = "남기는말"
        }
    }
    let type: TabBarPage
    let title: String
    @Binding var selection: TabBarPage
    var body: some View {
        Text(title)
            .font(SharedFontFamily.Pretendard.semiBold.swiftUIFont(size: 15))
            .foregroundStyle(type == selection ? ColorSet.main : Color.black)
            .frame(maxWidth: .infinity)

    }
}
