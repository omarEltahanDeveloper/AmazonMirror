//
//  ProductsView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct ProductsView: View {
    
    var listOfProducts : [productModel]
    @Binding var listOfProductsState : [productModel]
    @Binding var searchValue : String
    @Binding var selectedBar : HomeFullView
    @Binding var selectedProductDetails : productModel?
    let columns = [
        GridItem(.adaptive(minimum: (UIScreen.main.bounds.width / 2) - 30 ))
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(listOfProductsState) { product in
                        ProductItem(productImage: product.productImage, productName: product.productName, ratingCount: product.ratingCount, discount: product.discount, discountTime: product.discountTime, priceNow: product.priceNow, priceBefore: product.priceBefore)
                            .onTapGesture {
                                UserDefaults.standard.set(product.id, forKey: "productid")
                                selectedProductDetails = product
                                selectedBar = .details
                            }
                    }
                }.padding()
            }
            .onChange(of: searchValue, perform: { newValue in
                if newValue.isEmpty {
                    listOfProductsState = listOfProducts
                }
                else {
                    listOfProductsState.removeAll()
                    for i in listOfProducts {
                        if i.productName.lowercased().contains(newValue.lowercased()) {
                            listOfProductsState.append(i)
                        }
                    }
                    
                }
            })
            
        }
    }
}
//
//struct ProductsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsView(searchValue: .constant(""), selectedBar: .constant(.products), selectedProductDetails: .constant(productModel(id: 1, productImage: "ProductImage1", productName: "Samsung Galaxy A04e Dual SIM - 3GB Ram, 32GB size", ratingCount: 4, discount: 20, discountTime: "23:23", priceNow: 3349.00, priceBefore: "4,210.00", companyName: "Samsung", companyWebsite: "https://www.samsung.com/eg/", digitalStorage: "32 GB")))
//    }
//}
