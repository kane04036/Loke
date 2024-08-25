//
//  MarketSelectView.swift
//  Feature
//
//  Created by 제이콥 on 6/13/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import Shared

struct MarketSelectView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    var body: some View {
        VStack(spacing: 0) {
            TitleOfSignUpView(title: "선호하는 주변 상권 업종을\n선택해주세요")
            TagView
                .padding(.top, 40)

        }
    }
    
    var TagView: some View {
        VStack(spacing: 13, content: {
            ForEach(getRows(), id: \.self){ row in
                HStack(spacing: 11, content: {
                    ForEach(row, id: \.self){ market in
                        RoundedToggleButton(title: market.name, item: market, list: $signUpViewModel.selectedMarkets)
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            }
        })
    }
    
    // MARK: - Methods
    private func getTextWidth(term: String) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font: SharedFontFamily.Pretendard.semiBold.font(size: 16)]
        var width = (term as NSString).size(withAttributes: fontAttribute).width
        width += 20
        width += 10
        return width
    }
    
    private func getRows() ->[[Market]] {
        var sumWidth: CGFloat = 0
        var returnValue:[[Market]] = [[]]
        let screen = UIScreen.main.bounds.width - 40 //좌우 여백 20씩
        var index = 0
        let markets = MarketHelper().markets
        for market in markets {
            let textWidth = getTextWidth(term: market.name)
            if sumWidth + textWidth > screen{
                sumWidth = textWidth
                index += 1
                returnValue.append([])
                returnValue[index].append(market)
            }else {
                sumWidth += textWidth
                returnValue[index].append(market)
            }
        }
        return returnValue
    }
    
    private func getMarketInstance() -> Market {
        return Market(code: "", name: "")
    }
}

#Preview {
    MarketSelectView()
}


