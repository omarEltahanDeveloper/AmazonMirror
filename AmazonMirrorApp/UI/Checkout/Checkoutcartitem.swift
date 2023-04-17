//
//  CartItem.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 15/04/2023.
//

import SwiftUI

struct Checkoutcartitem: View {
    var productItem : Products
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(productItem.productimage ?? "").resizable().scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 4 ,height: UIScreen.main.bounds.width / 4)
                VStack(alignment: .leading,spacing: 5) {
                    Text(productItem.productname ?? "")
                        .font(.system(size: 14,weight: .medium))
                        .lineLimit(4)
                    HStack(alignment: .top,spacing: 0) {
                        Text("EGP")
                            .font(.system(size: 14,weight: .medium))
                        Text(String(productItem.productprice * Double(productItem.quantity)))
                            .font(.system(size: 14,weight: .medium))
                    }
                    
                    Text("Sold by Amazon.eg")
                        .font(.system(size: 14,weight: .medium))
                        .foregroundColor(.gray)
                    
                }
            }
        }.padding(.bottom,5)
    }    
}
//
//struct Checkoutcartitem_Previews: PreviewProvider {
//    static var previews: some View {
//        Checkoutcartitem(productItem: )
//    }
//}
