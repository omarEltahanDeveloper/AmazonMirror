//
//  ProductItem.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct ProductItem: View {
    
    let productImage : String
    let productName : String
    let ratingCount : Int
    let discount : Int
    let discountTime : String
    let priceNow : Double
    let priceBefore : String


    var body: some View {
        VStack(alignment: .leading,spacing: 2) {
            ZStack {
                Image(productImage).resizable().scaledToFit()
                    .frame(height: 100)
            }
            .padding(30)
            .background(Color("LightGrey"))
            
               
            Text(productName)
                .font(.system(size: 16,weight: .medium))
            
            HStack(spacing: 0) {
                ForEach(0..<5) { number in
                    if number < ratingCount {
                        Image("star-on")
                            .renderingMode(.template).foregroundColor(Color("RatingColor"))
                    } else {
                        Image("star-off")
                            .renderingMode(.template).foregroundColor(Color("RatingColor"))
                    }
                }
                Text(String(ratingCount))
                    .font(.system(size: 14,weight: .regular))
                    .padding(.leading,2)
            }
            
            HStack {
                Text(String(discount) + "% off")
                    .font(.system(size: 12,weight: .medium))
                    .foregroundColor(Color.white)
                    .padding(7)
                    .background(Color("RedColor"))
                Text("Ends in " + discountTime)
                    .font(.system(size: 12,weight: .regular))
                    .foregroundColor(Color("RedColor"))
            }.padding(.vertical,5)
            
            
            HStack(spacing: 0) {
                Text("EGP")
                    .font(.system(size: 16,weight: .light))
                Text(String(priceNow))
                    .font(.system(size: 20,weight: .semibold))
            }
            
            HStack {
                Text("Last Price")
                    .font(.system(size: 14,weight: .light))
                Text(priceBefore)
                    .font(.system(size: 16,weight: .light))
                    .strikethrough()
            }
            
            Text("FREE shipping")
                .font(.system(size: 12,weight: .regular))
                .foregroundColor(Color("DarkBlue"))

            
        }

    }
}

struct ProductItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductItem(productImage: "ProductImage1", productName: "Samsung Galaxy A04e Dual SIM - 3GB Ram, 32GB size", ratingCount: 4, discount: 20, discountTime: "23:23", priceNow: 3349.00, priceBefore: "EGP4,210.00")
    }
}
