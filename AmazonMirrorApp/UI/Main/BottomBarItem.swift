//
//  BottomBarItem.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 15/04/2023.
//

import SwiftUI

struct BottomBarItem: View {
    var iconName : String
    var isSelectedBar : Bool
    @Binding var countOfCart : Int
    var body: some View {
        VStack {
            Divider().frame(width: 44,height: 4,alignment: .center).background(isSelectedBar ? Color("DarkBlue") : Color.white)
            VStack(alignment: .center, spacing: -10) {
                Text(String(countOfCart))
                    .font(.system(size: 12, weight: .bold))
                    .frame(width: 25, height: 25)
                    .foregroundColor(isSelectedBar ? Color("DarkBlue") : Color.black)
                    .isHidden(countOfCart == 0)
                Image(iconName).renderingMode(.template).foregroundColor(isSelectedBar ? Color("DarkBlue") : Color.black)
                
            }.padding(.bottom,5)

        }.frame(width: UIScreen.main.bounds.width / 4)
    }
}

struct BottomBarItem_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarItem(iconName: "cart", isSelectedBar: true, countOfCart: .constant(1))
    }
}
