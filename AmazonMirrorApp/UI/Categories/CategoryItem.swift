//
//  CategoryItem.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 16/04/2023.
//

import SwiftUI

struct CategoryItem: View {
    let categoryImage : String
    let categoryName : String
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                Image(categoryImage).resizable()
                    .frame(height: 122)
            }
            
            Text(categoryName)
                .font(.system(size: 13,weight: .regular))
                .frame(width: (UIScreen.main.bounds.width / 2) - 25,height: 25)
                .background(Color("Light"))

        }.frame(width: (UIScreen.main.bounds.width / 2) - 25)
        
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(categoryImage: "", categoryName: "")
    }
}
